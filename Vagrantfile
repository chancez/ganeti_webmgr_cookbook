# -*- mode: ruby -*-
# vi: set ft=ruby :

GWM_LOCATION = '~/projects/ganeti_webmgr/'
MOUNT_POINT = '/home/vagrant/ganeti_webmgr'

Vagrant.configure("2") do |config|
  config.vm.hostname = "gwm"
  config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
  config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"
  config.vm.network :private_network, ip: "33.33.33.50"

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # Symlink our project for development purposes.
  config.vm.synced_folder GWM_LOCATION, MOUNT_POINT

  config.vm.provision :chef_solo do |chef|
    chef.environments_path = "environments"
    chef.environment = "vagrant"

    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      },
      :ganeti_webmgr => {
        :migrate => true,
        :bootstrap_user => true,
        :admin_username => 'vagrant',
        :admin_password => 'vagrant'
      }
    }
    chef.run_list = [
        "recipe[ganeti_webmgr::mysql]",
        # Uncomment if you want a test user created in GWM
        # "recipe[ganeti_webmgr::bootstrap_user]"
    ]
  end
end
