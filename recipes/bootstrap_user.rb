python_bin = ::File.join(node['ganeti_webmgr']['virtualenv'], 'bin', 'python')
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
  cwd manage_dir
  environment ({'DJANGO_SETTINGS_MODULE' => 'ganeti_web.settings'})
end