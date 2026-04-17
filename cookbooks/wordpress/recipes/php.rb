# Instalar extensiones PHP necesarias para WordPress
%w[
  php
  php-mysql
  php-curl
  php-gd
  php-mbstring
  php-xml
  php-zip
].each do |pkg|
  package pkg do
    action :install
  end
end

# libapache2-mod-php requiere reiniciar Apache al instalarse
package 'libapache2-mod-php' do
  action   :install
  notifies :restart, 'service[apache2]', :delayed
end
