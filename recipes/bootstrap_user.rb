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

venv = node['ganeti_webmgr']['virtualenv']
venv_exists = !venv.to_s.empty?

python_bin = venv_exists ? ::File.join(venv, "bin", "python") : "python"
manage_loc = File.join(node['ganeti_webmgr']['path'], node['ganeti_webmgr']['manage_file'])
manage_dir = File.dirname(manage_loc)

username = node['ganeti_webmgr']['admin_username'] || 'admin'
password = node['ganeti_webmgr']['admin_password'] || 'password'
email = node['ganeti_webmgr']['admin_email'] || 'admin@example.com'

execute "bootstrap_user" do
  command <<-EOS
  #{python_bin} manage.py createsuperuser --noinput --username=#{username} --email #{email}
  #{python_bin} -c \"from django.contrib.auth.models import User;u=User.objects.get(username='#{username}');u.set_password('#{password}');u.save();\"
  EOS
  user node['ganeti_webmgr']['owner']
  group node['ganeti_webmgr']['group']
  cwd manage_dir
  environment ({'DJANGO_SETTINGS_MODULE' => 'ganeti_web.settings'})
end