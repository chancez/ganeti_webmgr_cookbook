# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "gwm"
  config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
  config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"
  config.vm.network :private_network, ip: "33.33.33.10"

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # Symlink our project for development purposes.
  config.vm.synced_folder "~/projects/ganeti_webmgr", "/mnt/ganeti_webmgr"

  config.vm.provision :chef_solo do |chef|
    # These could be causing chef to not run..
    chef.environments_path = "environments"
    chef.environment = "vagrant"

    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      },
      :ganeti_webmgr => {
        'synced_folder' => '/mnt/ganeti_webmgr'
      }
    }

    chef.run_list = [
        "recipe[ganeti_webmgr::default]"
    ]
  end
end
