default['ganeti_webmgr']['path'] = path = "/var/lib/django/ganeti_webmgr"
default['ganeti_webmgr']['owner'] = nil
default['ganeti_webmgr']['group'] = nil

default['ganeti_webmgr']['repository'] = "https://github.com/osuosl/ganeti_webmgr"
default['ganeti_webmgr']['revision'] = "develop"

case node['platform']
when 'redhat', 'centos', 'fedora'
  default['ganeti_webmgr']['packages'] = ['libffi-devel']
when 'debian', 'ubuntu'
  default['ganeti_webmgr']['packages'] = ['libffi-dev']
else
  default['ganeti_webmgr']['packages'] = []
end


default['ganeti_webmgr']['pip_packages'] = []
default['ganeti_webmgr']['virtualenv'] = nil

default['ganeti_webmgr']['requirements'] = "requirements/production.txt"
default['ganeti_webmgr']['debug'] = false
default['ganeti_webmgr']['settings_template'] = "settings.py.erb"
default['ganeti_webmgr']['local_settings_file'] = "ganeti_webmgr/ganeti_web/settings/settings.py"
default['ganeti_webmgr']['overwrite_settings'] = false
default['ganeti_webmgr']['migrate'] = false
default['ganeti_webmgr']['settings'] = {}
default['ganeti_webmgr']['manage_file'] = "ganeti_webmgr/manage.py"
default['ganeti_webmgr']['collectstatic_dir'] = ::File.join(path, 'collected_static')

default['ganeti_webmgr']['database']['engine'] = "sqlite3"
# Load the DB Credentials using the databag as defaults.
default['ganeti_webmgr']['database']['name'] = ::File.join(path, 'ganeti.db')
default['ganeti_webmgr']['database']['user'] = nil
default['ganeti_webmgr']['database']['password'] = nil
default['ganeti_webmgr']['database']['host'] = nil
default['ganeti_webmgr']['database']['port'] = nil

default['ganeti_webmgr']['admin_username'] = nil
default['ganeti_webmgr']['admin_password'] = nil
default['ganeti_webmgr']['admin_email'] = nil

default['ganeti_webmgr']['host'] = node['fqdn']
default['ganeti_webmgr']['port'] = 8000

default['ganeti_webmgr']['http_proxy']['variant'] = nil
default['ganeti_webmgr']['http_proxy']['host_name'] = node['fqdn']
default['ganeti_webmgr']['http_proxy']['host_aliases'] = []
default['ganeti_webmgr']['http_proxy']['listen_ports'] = [ 80 ]

default['ganeti_webmgr']['hostsfile'] = {}

default['ganeti_webmgr']['auth_proxy']['host'] = node['fqdn'] # Always use the FQDN
default['ganeti_webmgr']['auth_proxy']['port'] = 8888

default['nginx']['default_site_enabled'] = false
