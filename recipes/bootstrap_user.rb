#
# Cookbook Name:: ganeti_webmgr
# Recipe:: boostrap_user
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

venv = node['ganeti_webmgr']['install_dir']
venv_bin = ::File.join(venv, 'bin')
python = ::File.join(venv_bin, 'python')
django_admin = ::File.join(venv_bin, 'django-admin.py')

username = node['ganeti_webmgr']['admin_username'] || 'admin'
password = node['ganeti_webmgr']['admin_password'] || 'password'
email = node['ganeti_webmgr']['admin_email'] || 'admin@example.com'

env = {
  "GWM_CONFIG_DIR" => "#{node['ganeti_webmgr']['config_dir']}" ,
  "DJANGO_SETTINGS_MODULE" => "ganeti_webmgr.ganeti_web.settings"
}

execute "bootstrap_superuser" do
  command <<-EOS
  #{django_admin} createsuperuser --noinput --username=#{username} --email #{email}
  #{python} -c \"from django.contrib.auth.models import User;u=User.objects.get(username='#{username}');u.set_password('#{password}');u.save();\"
  EOS
  user node['ganeti_webmgr']['user']
  group node['ganeti_webmgr']['group']
  environment env
end