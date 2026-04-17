# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  # Instalar Chef Infra Client antes del aprovisionamiento
  config.vm.provision "shell", inline: <<-SHELL
    curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 18
  SHELL

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.recipe = "principal::default"
    chef.json = {
      "wordpress" => {
        "url" => "http://192.168.33.10",
        "document_root" => "/var/www/wordpress",
        "db_name" => "wordpress_db",
        "db_user" => "wp_user",
        "db_password" => "wp_password",
        "db_host" => "localhost",
        "title" => "TechOps Solutions, S.A",
        "admin_user" => "admin",
        "admin_password" => "admin123",
        "admin_email" => "admin@example.com"
      }
    }
  end
end
