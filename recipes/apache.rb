include_recipe "apache2::default"
include_recipe "apache2::mod_wsgi"

env = {
  "GWM_CONFIG_DIR" => "#{node['ganeti_webmgr']['config_dir']}" ,
  "DJANGO_SETTINGS_MODULE" => "ganeti_webmgr.ganeti_web.settings"
}

gwm = node['ganeti_webmgr']
python_path = ::File.join(gwm['install_dir'], 'lib', 'python2.6', 'site-packages')
wsgi_path = ::File.join(python_path, 'ganeti_webmgr', 'ganeti_web', 'wsgi.py')

venv = gwm['install_dir']
venv_bin = ::File.join(venv, 'bin')
django_admin = ::File.join(venv_bin, 'django-admin.py')

execute "collect_static" do
  command "#{django_admin} collectstatic --noinput"
  environment env
  user node['ganeti_webmgr']['user']
  group node['ganeti_webmgr']['group']
end

web_app gwm['application_name'] do
  template 'gwm_apache_vhost.conf.erb'
  server_name node['hostname']
  server_aliases gwm['apache']['server_aliases']
  cookbook "ganeti_webmgr"
  server_name gwm['apache']['server_name']
  app gwm
  processes gwm['apache']['processes']
  threads gwm['apache']['threads']
  wsgi_process_group 'ganeti_webmgr'
  wsgi_path wsgi_path
  python_path python_path
end
