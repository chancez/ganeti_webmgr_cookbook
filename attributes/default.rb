default['ganeti_webmgr']['name'] = "ganeti_webmgr"
case node.chef_environment
when "vagrant"
  default['ganeti_webmgr']['path'] = "/home/vagrant/gwm"
  default['ganeti_webmgr']['owner'] = "vagrant"
  default['ganeti_webmgr']['group'] = "vagrant"
else
  default['ganeti_webmgr']['path'] = "/var/lib/django/gwm"
  default['ganeti_webmgr']['owner'] = "ganeti_web"
  default['ganeti_webmgr']['group'] = "ganeti_web"
end
path = default['ganeti_webmgr']['path']

default['ganeti_webmgr']['repository'] = "https://github.com/osuosl/ganeti_webmgr"
default['ganeti_webmgr']['revision'] = "develop"

default['ganeti_webmgr']['packages'] = ['git-core']
default['ganeti_webmgr']['pip_packages'] = []
default['ganeti_webmgr']['virtualenv'] = venv = "#{path}/venv"
default['ganeti_webmgr']['synced_folder'] = nil

default['ganeti_webmgr']['host'] = node['fqdn']
default['ganeti_webmgr']['port'] = 8000

default['ganeti_webmgr']['requirements'] = "requirements/production.txt"
default['ganeti_webmgr']['debug'] = false
default['ganeti_webmgr']['settings_template'] = "end_user.py.erb"
default['ganeti_webmgr']['local_settings_file'] = "ganeti_webmgr/ganeti_web/settings/end_user.py"
default['ganeti_webmgr']['overwrite_settings'] = false
default['ganeti_webmgr']['settings'] = {}
default['ganeti_webmgr']['manage_file'] = "ganeti_webmgr/manage.py"
default['ganeti_webmgr']['migrate'] = true

default['ganeti_webmgr']['database']['engine'] = engine = "mysql"
db = Chef::DataBagItem.load("database", engine)
# Load the DB Credentials using the databag as defaults.
default['ganeti_webmgr']['database']['name'] = db['name']
default['ganeti_webmgr']['database']['user'] = db['user']
default['ganeti_webmgr']['database']['password'] = db['password']
default['ganeti_webmgr']['database']['host'] = db['host']
default['ganeti_webmgr']['database']['port'] = db['port']

default['ganeti_webmgr']['collectstatic_dir'] = "#{path}/collected_static"

default['ganeti_webmgr']['http_proxy']['variant'] = "nginx"
default['ganeti_webmgr']['http_proxy']['host_name'] = node['fqdn']
default['ganeti_webmgr']['http_proxy']['host_aliases'] = []
default['ganeti_webmgr']['http_proxy']['listen_ports'] = [ 80 ]

default['nginx']['default_site_enabled'] = false
default['gunicorn']['virtualenv'] = venv
