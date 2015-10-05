# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

BOX_32BITS = "mast3rof0/lubuntu32"
BOX_64BITS = "mast3rof0/lubuntu64"

# Set the BOX (32 OR 64 BITS) you'd like to use
WHICH_BOX = BOX_32BITS

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = WHICH_BOX

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    vb.gui = true

    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.network :private_network, ip: "192.168.33.99"
  config.vm.network "forwarded_port", guest: 8042, host: 8042, auto_correct: true

  config.vm.provision "shell", path: "script-provision.sh"
end
