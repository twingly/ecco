Vagrant.configure("2") do |config|
  config.vm.define "ecco-test" do |ubuntu|
    ubuntu.vm.hostname = "ecco-test"
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.provision :ansible do |ansible|
      ansible.playbook = "vagrant/playbook.yml"
    end

    ubuntu.vm.network :forwarded_port, host: 3306, guest: 3306
  end
end
