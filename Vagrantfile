# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'fileutils'

SALT_VERSION = "v2014.7.0"

Vagrant.configure(2) do |config|

  # **** vm-test - Feature test runner ****

  config.vm.define "vm-test", primary: true do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "vm-test"

    # X forwarding for Firefox Browser
    unless ENV['NO_PUBLIC_PORTS']
      config.ssh.forward_x11 = true
      config.ssh.forward_agent = true
    end

    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "768"]
    end

    # http://fgrehm.viewdocs.io/vagrant-cachier
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
    end

    config.vm.synced_folder "test/salt", "/srv/salt"
    config.vm.synced_folder "test", "/home/vagrant/vm-test"

    config.vm.network "private_network", ip: "192.168.50.11"

    config.vm.provision :salt do |salt|
      salt.minion_config = "test/salt/minion"
      salt.run_highstate = true
      salt.verbose = true
      salt.install_type = "git"
      salt.bootstrap_options = "-g https://github.com/saltstack/salt.git"
      salt.install_args = SALT_VERSION
      salt.always_install = true
    end
  end # vm-test

end
