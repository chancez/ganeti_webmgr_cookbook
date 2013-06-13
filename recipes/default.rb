#
# Cookbook Name:: ganeti_webmgr
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe "nginx"

gwm = application "ganeti_webmgr" do
  path node['ganeti_webmgr']['path']
  owner "vagrant"
  group "vagrant"
  repository "https://github.com/ecnahc515/ganeti_webmgr"
  revision "deploy"
  migrate true
  # this needs to be another join instead of execute i think
  migration_command do
    execute "#{::File.join(node['ganeti_webmgr']['virtualenv'], 'bin', 'python')}" do
      #manage = ::File.join(node['ganeti_webmgr']['path'], 'current', 'manage.py')
      manage = ::File.join(release_path, "manage.py")
      command "#{manage} syncdb --migrate"
    end
  end
  packages ['git-core', 'htop']

  django do
    requirements "requirements/prod.txt"
    debug true
    local_settings_file "settings.py"
    settings_template "settings.py.erb"
    collectstatic true
    #{}"/home/vagrant/ganeti_webmgr/shared/env/bin/python manage.py migrate"
    database do
      database "ganeti.db"
      engine "sqlite3"
    end
  end

  gunicorn do
    app_module :django
    port 8000
  end

  self
end

# set up nginx
template "#{node['nginx']['dir']}/sites-available/#{gwm.name}.conf" do
  source "nginx_site.conf.erb"
  mode "664"
  owner "root"
  group "root"
  variables :resource => gwm, :application_port => 8000 # where gunicorn listens
  notifies :reload, resources(:service => 'nginx')
end

# enable the site (default action)
nginx_site "#{gwm.name}.conf"

# disable the default nginx site
nginx_site "default" do
  enable false
end
