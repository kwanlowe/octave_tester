# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "twistedbytes/centos-8"
  config.vm.box_version = "1905.1"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1024"
  end
 config.vm.provision "shell", inline: "sudo dnf -y install python3"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible_octave.yml"
    ansible.compatibility_mode = "2.0"
    ansible.extra_vars = {
      appcode: "Scanner",
      var_host: "all",
      ansible_python_interpreter: "/usr/bin/python3",
    }
  end
end
