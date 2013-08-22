default['ganeti_webmgr']['name'] = "ganeti_webmgr"
default['ganeti_webmgr']['path'] = "/home/vagrant/ganeti_webmgr"
default['ganeti_webmgr']['collectstatic_dir'] = "#{default['ganeti_webmgr']['path']}/shared/collected_static"

default['ganeti_webmgr']['gunicorn']['port'] = 8000
default['nginx']['default_site_enabled'] = false
