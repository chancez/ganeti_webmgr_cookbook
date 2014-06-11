include_recipe "apache2::default"
include_recipe "apache2::mod_wsgi"

gwm = node['ganeti_webmgr']

env = {
  "GWM_CONFIG_DIR" => "#{gwm['config_dir']}" ,
  "DJANGO_SETTINGS_MODULE" => "ganeti_webmgr.ganeti_web.settings"
}

python_version = node['languages']['python']['version']
# virtualenvs only have the major version
# (ie: 2.6, not 2.6.6)
version = python_version.split(".")
version = version[0] + "." + version[1]
python_version = "python#{version}"

python_path = ::File.join(gwm['install_dir'], 'lib', python_version, 'site-packages')
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
