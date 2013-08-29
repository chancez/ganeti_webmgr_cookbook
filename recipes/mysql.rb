node.override['ganeti_webmgr']['database']['engine'] = 'mysql'
include_recipe "mysql::server"
include_recipe "database::mysql"
# Bootstrap the DB
connection_info = {
    :host => node['ganeti_webmgr']['database']['host'],
    :username => 'root',
    :password => node['mysql']['server_root_password']}

mysql_database node['ganeti_webmgr']['database']['name'] do
  connection connection_info
  action :create
end

# Create our user
gwm_db_user = node['ganeti_webmgr']['database']['user']
mysql_database_user gwm_db_user do
  connection connection_info
  password node['ganeti_webmgr']['database']['password']
  action :create
end

# Give our user permissions to the DB
mysql_database_user gwm_db_user do
  connection connection_info
  database_name node['ganeti_webmgr']['database']['name']
  privileges [:all]
  action :grant
end

include_recipe "ganeti_webmgr::default"
