#
# Cookbook Name:: ganeti_webmgr
# Recipe:: default
#
# Copyright 2013 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "python"
include_recipe "git"

# Make sure the directory for GWM exists before we try to clone to it
directory node['ganeti_webmgr']['path'] do
  owner node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  recursive true
  action :create
end

no_clone = (node.chef_environment == "vagrant" &&
  ::File.directory?(::File.join(node['ganeti_webmgr']['path'], '.git'))

git node['ganeti_webmgr']['path'] do
  repository node['ganeti_webmgr']['repository']
  revision node['ganeti_webmgr']['revision']
  user node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  not_if { no_clone }
end

log "Installing system packages for Ganeti Web Manager"
node['ganeti_webmgr']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

venv = node['ganeti_webmgr']['virtualenv']
venv_exists = !venv.to_s.empty?

if venv_exists
  log "Creating Virtualenv"
  python_virtualenv venv do
    owner node['ganeti_webmgr']['owner']
    group node['ganeti_webmgr']['group']
    action :create
  end
else
  log "Virtualenv attribute not set. Not creating a virtualenv"
end

db_engine = node['ganeti_webmgr']['database']['engine']

# include proper recipes and the correct python db driver
db_pip_packages = case db_engine
when "mysql"
  include_recipe "mysql::client"
  ['mysql-python']
when "psycopg2"
  include_recipe "postgresql"
  ['psycopg2']
when "sqlite3"
  include_recipe "sqlite"
  ['']
else
  log "Node attribute ['ganeti_webmgr']['database']['engine']"\
      "not set. Defaulting to sqlite" do
    level :warn
  end
  include_recipe "sqlite"
  ['']
end


# Install GWM as a python package
python_pip node['ganeti_webmgr']['path'] do
  virtualenv venv if venv
  user node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  action :install
end


# install the extra python dependencies (db drivers, and anything in attributes)
log "Installing extra pip packages"

# Merge the two lists of python package dependencies
(node['ganeti_webmgr']['pip_packages'] | db_pip_packages).each do |pkg|
  python_pip pkg do
    virtualenv venv if venv
    user node['ganeti_webmgr']['owner']
    group node['ganeti_webmgr']['group']
    action :install
  end
end

# TODO: Needs testing
settings_location = ::File.join(node['ganeti_webmgr']['path'], node['ganeti_webmgr']['local_settings_file'])
create_settings = false
log "Creating settings file"
if File.exists?(settings_location)
  if node['ganeti_webmgr']['overwrite_settings']
    msg = "Overwriting existing settings file because attribute "\
          "'overwrite_settings' is set to #{node['ganeti_webmgr']['overwrite_settings']}."
    create_settings = true
  else
    msg = "Skipping copying settings. Settings file already exists."
  end
  log msg do
    level :warn
  end
else
  log "No settings file found. Creating at #{settings_location}."
  create_settings = true
end

template settings_location do
  source node['ganeti_webmgr']['settings_template'] || "settings.py.erb"
  owner node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  mode 0644
  variables node['ganeti_webmgr']['settings'].dup
  variables.update({
    :app => node['ganeti_webmgr'],
    :debug => node['ganeti_webmgr']['debug'],
    :auth_proxy => node['ganeti_webmgr']['auth_proxy'],
    :database => {
      :settings => node['ganeti_webmgr']['database'],
      :host => node['ganeti_webmgr']['database']['host']
    }
  })
  only_if { create_settings }
end

# bootstrap DB to ensure our database exists and our db user exists
include_recipe "ganeti_webmgr::database" unless db_engine.to_s.empty? or
  db_engine == 'sqlite3'

# Migrations

# Use global python interpreter or the virtualenv python if it exists
python = venv_exists ? ::File.join(venv, "bin", "python") : "python"

# Setup our commands to run manage.py with the virtualenv
manage_loc = ::File.join(node['ganeti_webmgr']['path'], node['ganeti_webmgr']['manage_file'])
manage_cmd = "#{python} #{node['ganeti_webmgr']['manage_file']}"
syncdb_cmd = "#{manage_cmd} syncdb --noinput"
migrate_cmd = "#{manage_cmd} migrate"

log "Migration Commands" do
  level :debug
  message "syncdb_cmd: #{syncdb_cmd}\nmigrate_cmd: #{migrate_cmd}"
end

execute "run_migrations" do
  user node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  cwd node['ganeti_webmgr']['path']
  command "#{syncdb_cmd} && #{migrate_cmd}"
  only_if { node['ganeti_webmgr']['migrate'] && ::File.exists?(manage_loc) }
end

include_recipe "ganeti_webmgr::proxy"
include_recipe "ganeti_webmgr::hosts"
