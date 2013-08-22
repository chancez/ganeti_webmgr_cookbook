include_recipe "nginx"

app = node['ganeti_webmgr']
host_name = app['http_proxy']['hostname'] || node['fqdn']

template "#{node['nginx']['dir']}/sites-available/ganeti_webmgr.conf" do
  source "nginx_site.conf.erb"
  mode 0664
  owner "root"
  group "root"
  variables(
    :app          => app,
    :host_name    => host_name,
    :host_aliases => app['http_proxy']['host_aliases'],
    :listen_ports => app['http_proxy']['listen_ports']
  )
  notifies :reload, "service[nginx]"
end

nginx_site "ganeti_webmgr.conf" do
  enable true
end
