Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "vagrant/playbook.yml"
  end

  config.vm.network :forwarded_port, host: 3306, guest: 3306
end
