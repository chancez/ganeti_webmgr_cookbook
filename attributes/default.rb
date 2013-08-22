default['ganeti_webmgr']['name'] = "ganeti_webmgr"
default['ganeti_webmgr']['path'] = "/home/vagrant/ganeti_webmgr"

default['ganeti_webmgr']['user'] = "ganeti_webmgr"
default['ganeti_webmgr']['group'] = "ganeti_webmgr"
default['ganeti_webmgr']['host'] = node['fqdn']
default['ganeti_webmgr']['port'] = 8000

default['ganeti_webmgr']['collectstatic_dir'] = "#{default['ganeti_webmgr']['path']}/shared/collected_static"

default['ganeti_webmgr']['http_proxy']['variant'] = "nginx"
default['ganeti_webmgr']['http_proxy']['host_name'] = nil
default['ganeti_webmgr']['http_proxy']['host_aliases'] = []
default['ganeti_webmgr']['http_proxy']['listen_ports'] = [ 80 ]

default['nginx']['default_site_enabled'] = false
