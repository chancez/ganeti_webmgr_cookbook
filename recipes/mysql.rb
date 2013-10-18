# Make sure our settings in Django are set correctly to mysql
node.override['ganeti_webmgr']['database']['engine'] = 'mysql'
# install mysql
include_recipe "mysql::ruby"
include_recipe "mysql::server"
# bootstrap DB
include_recipe "ganeti_webmgr::database"
