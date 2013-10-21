# Recipe to do database agnostic boostrapping
# Creates a database, and a database user for development

db_host = node['ganeti_webmgr']['database']['host']
db_port = node['ganeti_webmgr']['database']['port']
mysql_connection_info = {
    :host => db_host,
    :port => db_port,
    :username => 'root',
    :password => node['mysql']['server_root_password']
}

# postgres example not tested:
postgresql_connection_info = {
  :host => db_host,
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

case node['ganeti_webmgr']['database']['engine']
when 'mysql'
  db_provider = Chef::Provider::Database::Mysql
  db_user_provider = Chef::Provider::Database::MysqlUser
  connection_info = mysql_connection_info
when 'psycopg2'
  db_provider = Chef::Provider::Database::Postgresql
  db_user_provider = Chef::Provider::Database::PostgresqlUser
  connection_info = postgresql_connection_info
end

log "Creating Database with name #{node.ganeti_webmgr.database.name}"
database node['ganeti_webmgr']['database']['name'] do
  provider db_provider
  connection connection_info
  action :create
end

# Create our user
gwm_db_user = node['ganeti_webmgr']['database']['user']
database_user gwm_db_user do
  provider db_provider
  connection connection_info
  database_name node['ganeti_webmgr']['database']['name']
  password node['ganeti_webmgr']['database']['password']
  action :create
end

# Give our user permissions to the DB
database_user gwm_db_user do
  provider db_user_provider
  connection connection_info
  database_name node['ganeti_webmgr']['database']['name']
  privileges [:all]
  action :grant
end

include_recipe "ganeti_webmgr::default"
