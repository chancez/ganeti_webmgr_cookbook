default['ganeti_webmgr']['name'] = "ganeti_webmgr"
default['ganeti_webmgr']['path'] = path = "/home/vagrant/gwm"
default['ganeti_webmgr']['packages'] = ['git-core']
default['ganeti_webmgr']['pip_packages'] = []
default['ganeti_webmgr']['virtualenv'] = "#{path}/venv"
default['ganeti_webmgr']['synced_folder'] = nil

default['ganeti_webmgr']['owner'] = "vagrant"
default['ganeti_webmgr']['group'] = "vagrant"
default['ganeti_webmgr']['host'] = node['fqdn']
default['ganeti_webmgr']['port'] = 8000

default['ganeti_webmgr']['requirements'] = "requirements/prod.txt"
default['ganeti_webmgr']['debug'] = false
default['ganeti_webmgr']['settings_template'] = "end_user.py.erb"
default['ganeti_webmgr']['local_settings_file'] = "ganeti_web/ganeti_web/settings/end_user.py"
default['ganeti_webmgr']['settings'] = {}
default['ganeti_webmgr']['manage_file'] = "ganeti_web/manage.py"

default['ganeti_webmgr']['database']['engine'] = engine = "mysql"
db = Chef::DataBagItem.load("database", engine)
# Load the DB Credentials using the databag as defaults.
default['ganeti_webmgr']['database']['name'] = db['name']
default['ganeti_webmgr']['database']['user'] = db['user']
default['ganeti_webmgr']['database']['password'] = db['password']
default['ganeti_webmgr']['database']['host'] = db['host']
default['ganeti_webmgr']['database']['port'] = db['port']

default['ganeti_webmgr']['collectstatic_dir'] = "#{default['ganeti_webmgr']['path']}/shared/collected_static"

default['ganeti_webmgr']['http_proxy']['variant'] = "nginx"
default['ganeti_webmgr']['http_proxy']['host_name'] = nil
default['ganeti_webmgr']['http_proxy']['host_aliases'] = []
default['ganeti_webmgr']['http_proxy']['listen_ports'] = [ 80 ]

default['nginx']['default_site_enabled'] = false
