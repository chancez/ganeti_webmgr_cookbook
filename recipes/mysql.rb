#
# Cookbook Name:: ganeti_webmgr
# Recipe:: mysql
#
# Copyright 2013 OSU Open Source Lab
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and


# Make sure our settings in Django are set correctly to mysql
node.override['ganeti_webmgr']['database']['engine'] = 'mysql'
# install mysql
include_recipe "mysql::ruby"
include_recipe "mysql::server"
# bootstrap DB
include_recipe "ganeti_webmgr::database"
