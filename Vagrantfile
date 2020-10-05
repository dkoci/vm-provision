# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes
# If this number is changed, remember to update setup-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
NUM_MASTER_NODE = 2
NUM_WORKER_NODE = 2

IP_MASTER_NW = "192.168.10."
IP_WORKER_NW = "192.168.20."
MASTER_IP_START = 0
NODE_IP_START = 0

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "base"
  config.vm.box = "ubuntu/bionic64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
      config.vm.define "kmaster0#{i}" do |node|
        # Name shown in the GUI
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kmaster0#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kmaster0#{i}"
        node.vm.network :private_network, ip: IP_MASTER_NW + "#{MASTER_IP_START + i}"
        node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"

        node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end

        node.vm.provision "setup-dns", type: "shell", :path => "scripts/update-dns.sh"
        node.vm.provision "allow-bridge-nf-traffic", :type => "shell", :path => "scripts/allow-bridge-nf-traffic.sh"
        node.vm.provision "install-docker", type: "shell", :path => "scripts/install-docker-2.sh"

      end
  end


  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "kworker0#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kworker0#{i}"
            vb.memory = 512
            vb.cpus = 1
        end
        node.vm.hostname = "kworker0#{i}"
        node.vm.network :private_network, ip: IP_WORKER_NW + "#{NODE_IP_START + i}"
        node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"

        node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end

        node.vm.provision "setup-dns", type: "shell", :path => "scripts/update-dns.sh"
        node.vm.provision "allow-bridge-nf-traffic", :type => "shell", :path => "scripts/allow-bridge-nf-traffic.sh"
        node.vm.provision "install-docker", type: "shell", :path => "scripts/install-docker-2.sh"
    end
  end

<<<<<<< HEAD
# Provision Load Balancer Node
config.vm.define "loadbalancer" do |node|
=======
  # Provision Load Balancer Node
  config.vm.define "loadbalancer" do |node|
>>>>>>> 4b85b8e63777216e157281e2e90108275f0e5738
    node.vm.provider "virtualbox" do |vb|
        vb.name = "loadbalancer"
        vb.memory = 512
        vb.cpus = 1
    end
    node.vm.hostname = "loadbalancer"
    node.vm.network :private_network, ip: "192.168.30.1"
	node.vm.network "forwarded_port", guest: 22, host: 2731

    node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
      s.args = ["enp0s8"]
    end

    node.vm.provision "setup-dns", type: "shell", :path => "scripts/update-dns.sh"

end

  # Provision Private Docker Registry Node
  config.vm.define "docker-registry" do |node|
    node.vm.provider "virtualbox" do |vb|
        vb.name = "docker-registry"
        vb.memory = 512
        vb.cpus = 1
    end
    node.vm.hostname = "docker-registry"
    node.vm.network :private_network, ip: "192.168.30.2"
	node.vm.network "forwarded_port", guest: 22, host: 2732

    node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
      s.args = ["enp0s8"]
    end

    node.vm.provision "setup-dns", type: "shell", :path => "scripts/update-dns.sh"
    node.vm.provision "allow-bridge-nf-traffic", :type => "shell", :path => "scripts/allow-bridge-nf-traffic.sh"
    node.vm.provision "install-docker", type: "shell", :path => "scripts/install-docker-2.sh"

  end
end
