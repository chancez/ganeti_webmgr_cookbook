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

log "Installing system packages for Ganeti Web Manager"
node['ganeti_webmgr']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

venv = node['ganeti_webmgr']['virtualenv']
if venv
  log "Creating Virtualenv"
  python_virtualenv venv do
    owner node['ganeti_webmgr']['owner']
    group node['ganeti_webmgr']['group']
    action :create
  end
else
  log "Virtualenv attribute not set. Not creating a virtualenv"
end

# include proper recipes and install the db driver
db_pip_packages = case node['ganeti_webmgr']['database']['engine']
when "mysql"
  include_recipe "mysql"
  'mysql-python'
when "psycopg2"
  include_recipe "postgresql"
  'psycopg2'
when "sqlite3"
  include_recipe "sqlite"
  ''
else
  log "Node attribute ['ganeti_webmgr']['database']['engine']"\
      "not set. Defaulting to sqlite" do
    level :warn
  end
  include_recipe "sqlite"
  ''
end

log "Installing pip packages"
python_pkgs = node['ganeti_webmgr']['pip_packages'].dup
# Add our db packages if they arent in the list already
python_pkgs.push(db_pip_packages) unless python_pkgs.include?(db_pip_packages)
python_pkgs.each do |pkg|
  python_pip pkg do
    virtualenv venv if venv
    user node['ganeti_webmgr']['owner']
    group node['ganeti_webmgr']['group']
    action :install
  end
end

requirements = ::File.join(node['ganeti_webmgr']['path'], node['ganeti_webmgr']['requirements'])
log "Installing requirements.txt from #{requirements}"
python_pip requirements do
  virtualenv venv if venv
  options "-r"
  user node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  action :install
end

# TODO: Needs testing
settings_location = ::File.join(node['ganeti_webmgr']['path'], node['ganeti_webmgr']['local_settings_file'])
create_settings = false
log "Creating settings file"
if File.exists?(settings_location)
  if node['ganeti_webmgr']['overwrite_settings']
    msg = "Overwriting existing settings file because attribute "\
          "'overwrite_settings' is set to #{node.ganeti_webmgr.overwrite_settings}."
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

if create_settings
  template settings_location do
    source node['ganeti_webmgr']['settings_template'] || "settings.py.erb"
    owner node['ganeti_webmgr']['owner']
    group node['ganeti_webmgr']['group']
    mode 0644
    variables node['ganeti_webmgr']['settings'].dup
    variables.update({
      :app => node['ganeti_webmgr'],
      :debug => node['ganeti_webmgr'].debug,
      :database => {
        :settings => node['ganeti_webmgr']['database'],
        :host => node['ganeti_webmgr']['database']['host']
      }
    })
  end
end

# Migrations
if node['ganeti_webmgr']['migrate']
  log "Running migrations"
  # Setup our commands to run manage.py with the virtualenv
  manage_loc = ::File.join(node['ganeti_webmgr']['path'], node['ganeti_webmgr']['manage_file'])
  manage_cmd = "#{::File.join(venv, "bin", "python")} #{node.ganeti_webmgr.manage_file}"
  syncdb_cmd = "#{manage_cmd} syncdb --noinput"
  migrate_cmd = "#{manage_cmd} migrate"

  log "Migration Commands" do
    level :debug
    message "syncdb_cmd: #{syncdb_cmd}\nmigrate_cmd: #{migrate_cmd}"
  end

  execute "run_migrations" do
    cwd node['ganeti_webmgr']['path']
    command "#{syncdb_cmd} && #{migrate_cmd}"
    only_if { ::File.exists?(manage_loc) }
  end
else
  log "Skipping migrations because the migrate attribute is set to #{node.ganeti_webmgr.migrate}."
end

include_recipe "ganeti_webmgr::proxy"

