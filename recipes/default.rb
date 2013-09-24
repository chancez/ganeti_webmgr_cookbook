#
# Cookbook Name:: ganeti_webmgr
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

app = node['ganeti_webmgr']
db = app['database']
venv = app["virtualenv"]
project_location = ::File.join(app.path, app.name)

include_recipe "python"

log "Creating project directory at #{app.path}"
directory app.path do
  owner app.owner if app.owner
  group app.group if app.group
  mode 0755
  action :create
  recursive true
end

log "Installing system packages for #{app.name}"
app['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

if node.chef_environment == "vagrant"
  if app.synced_folder.nil?
    raise "Node attribute synced_folder must be set."
  else
    log "Using Vagrant, symlinking project at #{project_location}"
    link project_location do
      to app.synced_folder
    end
  end
else
  # Non vagrant
end

log "Creating Virtualenv"
python_virtualenv venv do
  path venv
  owner app.owner
  group app.group
  action :create
end

# include proper recipes and install the db driver
db_pip_packages = case node['ganeti_webmgr']['database']['engine']
  when "mysql"
    include_recipe "mysql"
    ['mysql-python']
  when "postgresql_psycopg2"
    include_recipe "postgres"
    ['psycopg2']
  when "sqlite3"
    include_recipe "sqlite"
  end

log "Installing pip packages"
# Join the two lists of packages together (no dupes)
python_pkgs = app.pip_packages | db_pip_packages
python_pkgs.each do |pkg|
  python_pip pkg do
    virtualenv venv
    user app.owner
    group app.group
    action :install
  end
end

requirements = ::File.join(project_location, app.requirements)
log "Installing requirements.txt from #{requirements}"
python_pip requirements do
    virtualenv venv
    options "-r"
    user app.owner
    group app.group
    action :install
end

# TODO: Needs testing
settings_location = "#{project_location}/#{app.local_settings_file}"
log "Copying #{app.settings_template} to #{settings_location}"
settings_exist = File.exists?(settings_location)

if settings_exist
  if app.overwrite_settings
    msg = "Overwriting existing settings file because attribute 'overwrite_settings' is set to #{app.overwrite_settings}."
  else
    msg = "Skipping copying settings. Settings file already exists."
  end
  log msg do
    level :warn
  end
end

# WIP?
template settings_location do
  source app.settings_template || "settings.py.erb"
  owner app.owner
  group app.group
  mode 0644
  variables app.settings.dup
  variables.update({
    :app => app,
    :debug => app.debug,
    :database => {
      :settings => db,
      :host => db.host
    }
  })
  not_if { settings_exist && !app.overwrite_settings }
end

# Migrations
if app.migrate
  log "Running migrations"
  # Setup our commands to run manage.py with the virtualenv
  manage_cmd = "#{::File.join(venv, "bin", "python")} #{app.manage_file}"
  syncdb_cmd = "#{manage_cmd} syncdb --noinput"
  migrate_cmd = "#{manage_cmd} migrate"

  log "Migration Commands" do
    level :debug
    message "syncdb_cmd: #{syncdb_cmd}\nmigrate_cmd: #{migrate_cmd}"
  end

  execute "run_migrations" do
    cwd project_location
    command "#{syncdb_cmd} && #{migrate_cmd}"
    only_if { ::File.exists?("#{project_location}/#{app.manage_file}") }
  end
else
  log "Skipping migrations because the migrate attribute is set to #{app.migrate}."
end

# gunicorn_config app.path do
#   action :create
# end

if !app.http_proxy.variant.nil?
  include_recipe "ganeti_webmgr::proxy"
end
