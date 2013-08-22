
# Determine the HTTP Proxy by checking our attributes
variant = node['ganeti_webmgr']['http_proxy']['variant']
include_recipe "ganeti_webmgr::proxy_#{variant}"
