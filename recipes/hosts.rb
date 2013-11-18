node['ganeti_webmgr']['hostsfile'].each do |ip, hostname|
  hostsfile_entry ip do
    hostname hostname
    action :create
  end
end
