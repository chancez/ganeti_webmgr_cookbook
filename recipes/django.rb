application "ganeti_webmgr" do
  path "/home/vagrant/ganeti_webmgr"
  owner "vagrant"
  group "vagrant"
  repository "git://git.osuosl.org/gitolite/ganeti/ganeti_webmgr"
  revision "release/0.10"
  migrate true
  packages ["git-core"]

  django do
    requirements "requirements/prod.txt"
    debug true
    local_settings_file "settings.py"
    settings_template "settings.py.erb"
    # database do
    #   database "gwm"
    #   engine "sqlite3"
    # end
  end
end