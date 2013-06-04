#
# Cookbook Name:: ganeti_webmgr
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

application "ganeti_webmgr" do
  path "/home/vagrant/ganeti_webmgr"
  owner "vagrant"
  group "vagrant"
  repository "https://github.com/ecnahc515/ganeti_webmgr"
  revision "deploy"
  migrate true
  packages ["git-core"]

  django do
    requirements "requirements/prod.txt"
    packages ["gunicorn"]
    debug true
    local_settings_file "settings.py"
    settings_template "settings.py.erb"
    collectstatic true
    database do
      database "ganeti.db"
      engine "sqlite3"
    end
  end

  gunicorn do
    only_if { node['roles'].include? 'ganeti_webmgr_application_server' }
    app_module :django
    port 8080
    loglevel "debug"
  end

  nginx_load_balancer do
    only_if { node['roles'].include? 'ganeti_webmgr_load_balancer' }
    application_port 8080
    static_files "/static" => "static"
  end

end
