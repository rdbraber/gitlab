VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :gitlab do |gitlab_config|
    gitlab_config.vm.box = "bento/centos-6.7"
    gitlab_config.vm.hostname = "gitlab.denbraber.home"
    gitlab_config.vm.network "private_network", ip: "192.168.120.10"
    gitlab_config.vm.provision "shell", path: "configure_nodes.sh"
  end

  config.vm.provider "virtualbox" do |v|
       v.memory = 2048
       v.cpus = 2
    end
end
