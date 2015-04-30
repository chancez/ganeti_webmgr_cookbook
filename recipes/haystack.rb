#
# Cookbook Name:: ganeti_webmgr
# Recipe:: haystack
#
# Copyright 2013 Oregon State University
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
# limitations under the License.

directory node['ganeti_webmgr']['haystack_whoosh_path'] do
  owner 'apache'
  group 'apache'
  action :create
end

bash 'update haystack whoosh index' do
  code <<-EOH
    #DJANGO_SETTINGS_MODULE="ganeti_webmgr.ganeti_web.settings" \
    {node['ganeti_webmgr']['install_dir']}/bin/django-admin.py update_index
  EOH
end
