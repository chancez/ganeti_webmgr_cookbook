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
  owner app.owner
  group app.group
  mode 0744
  action :create
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
# host = search for db server
host = nil
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
      :host => host || db.host
    }
  })
  not_if { settings_exist }
end

log "Skipping copying settings. Settings file already exists" do
  level :warn
  only_if { settings_exist }
end

include_recipe "ganeti_webmgr::proxy"

# application app['name'] do
#   path app['path']
#   owner "vagrant"
#   group "vagrant"
#   repository "https://github.com/osuosl/ganeti_webmgr"
#   revision "feature/14625"
#   migrate true
#   rollback_on_error false
#   packages ["git-core"] | app['packages']


#   django do
#     requirements "requirements/prod.txt"
#     debug true
#     local_settings_file "ganeti_web/ganeti_web/settings/end_user.py"
#     settings_template "end_user.py.erb"
#     settings :app => app
#     collectstatic true
#     manage_file "ganeti_web/manage.py"
#     database do
#       database db['name']
#       engine db['engine']
#       user db['user']
#       password db['password']
#       host db['host']
#       port db['port']
#     end

#     manage_cmd = "#{::File.join(venv, "bin", "python")} #{manage_file}"
#     syncdb_cmd = "#{manage_cmd} syncdb --noinput"
#     migration_command "#{syncdb_cmd} && #{manage_cmd} migrate"

#   end

#   gunicorn do
#     app_module 'ganeti_web.wsgi:application'
#     port app['port']
#     directory "#{::File.join(app.path, "current", "ganeti_web")}"
#   end
#
# end

