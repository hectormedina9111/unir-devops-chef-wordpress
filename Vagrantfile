# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

    config.vm.define "server-wordpress" do |serverwordpress|
        server_ip = "192.168.33.20"

        serverwordpress.vm.hostname ="server-wordpress"
        serverwordpress.vm.network "forwarded_port", guest: 80, host: 80
        serverwordpress.vm.network "private_network", ip: server_ip

        serverwordpress.vm.provider "virtualbox" do |vb|
          vb.name = "server-wordpress"
          vb.memory = "1024"
        end

          # Instalar Chef Infra Client antes del aprovisionamiento
          serverwordpress.vm.provision "shell", inline: <<-SHELL
            apt-get update
            curl -L https://chef.io/chef/install.sh | sudo bash
          SHELL

          serverwordpress.vm.provision "chef_solo" do |chef|
            chef.cookbooks_path = "chef/cookbooks"
            chef.add_recipe  "principal"
            chef.arguments = "--chef-license accept -l info"
            chef.json = {
              "wordpress" => {
                "url" => "http://" + server_ip,
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
end
