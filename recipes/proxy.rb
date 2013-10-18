# Determine the HTTP Proxy by checking our attributes
variant = node['ganeti_webmgr']['http_proxy']['variant']
if !variant.nil?
  include_recipe "ganeti_webmgr::proxy_#{variant}"
end
