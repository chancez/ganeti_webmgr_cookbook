#
# Cookbook Name:: ganeti_webmgr
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

app = node['ganeti_webmgr']

application app['name'] do
  path app['path']
  owner "vagrant"
  group "vagrant"
  repository "https://github.com/osuosl/ganeti_webmgr"
  revision "feature/14625"
  migrate true
  # rollback_on_error false
  packages ["git-core"]

  django do
    requirements "requirements/prod.txt"
    debug true
    local_settings_file "ganeti_web/ganeti_web/settings/end_user.py"
    settings_template "end_user.py.erb"
    settings :app => app
    collectstatic true
    manage_file "ganeti_web/manage.py"
    database do
      database "#{app.path}/shared/ganeti.db"
      engine "sqlite3"
    end

    venv = "#{app.path}/shared/env"
    manage_cmd = "#{::File.join(venv, "bin", "python")} #{manage_file}"
    syncdb_cmd = "#{manage_cmd} syncdb --noinput"
    migration_command "#{syncdb_cmd} && #{manage_cmd} migrate"
  end

  gunicorn do
    app_module 'ganeti_web.wsgi:application'
    port app['port']
    directory "#{::File.join(app.path, "current", "ganeti_web")}"
  end

end

include_recipe "ganeti_webmgr::proxy"
