default['ganeti_webmgr']['path'] = "/opt/ganeti_webmgr_src"
default['ganeti_webmgr']['user'] = nil
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

default['ganeti_webmgr']['install_dir'] = '/opt/ganeti_webmgr'
default['ganeti_webmgr']['config_dir'] = '/opt/ganeti_webmgr/config'

default['ganeti_webmgr']['static_root'] = '/opt/ganeti_webmgr/collected_static'
default['ganeti_webmgr']['static_url'] = '/static'

default['ganeti_webmgr']['debug'] = false
default['ganeti_webmgr']['migrate'] = false

default['ganeti_webmgr']['haystack_whoosh_path'] = '/opt/ganeti_webmgr/whoosh_index'

default['ganeti_webmgr']['database']['engine'] = nil
# Load the DB Credentials using the databag as defaults.
default['ganeti_webmgr']['database']['name'] = nil
default['ganeti_webmgr']['database']['user'] = nil
default['ganeti_webmgr']['database']['password'] = nil
default['ganeti_webmgr']['database']['host'] = nil
default['ganeti_webmgr']['database']['port'] = nil

default['ganeti_webmgr']['admin_username'] = nil
default['ganeti_webmgr']['admin_password'] = nil
default['ganeti_webmgr']['admin_email'] = nil

default['ganeti_webmgr']['host'] = node['fqdn']
default['ganeti_webmgr']['port'] = 8000

default['ganeti_webmgr']['hostsfile'] = {}

default['ganeti_webmgr']['vnc_proxy'] = "#{node['fqdn']}:8888"

default['nginx']['default_site_enabled'] = false
