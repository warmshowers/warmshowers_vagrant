# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_PLUGINS = [ 'vagrant-hostmanager', 'vagrant-vbguest' ]

_retry = false
VAGRANT_PLUGINS.each do |plugin|
  unless Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}" 
    _retry = true
  end
end

if (_retry)
  exec "vagrant " + ARGV.join(' ')
end

Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|
  # We're using a default ubuntu box with php 5.5.9 installed.
  config.vm.box = "ubuntu/trusty64"

  # Enable ssh agent forwarding
  config.ssh.forward_agent = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Enable vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Providers
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  # Provisioners
  config.vm.provision "shell" do |s|
    s.path = "provision/setup.sh"
  end
end
