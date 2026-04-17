document_root = node['wordpress']['document_root']

# Instalar Apache2
package 'apache2' do
  action :install
end

# Crear directorio raíz del sitio
directory document_root do
  owner     'www-data'
  group     'www-data'
  mode      '0755'
  recursive true
  action    :create
end

# Servicio Apache — se reinicia cuando libapache2-mod-php sea instalado (via subscribes en php.rb)
service 'apache2' do
  action [:enable, :start]
end

# Configurar VirtualHost para WordPress
template '/etc/apache2/sites-available/wordpress.conf' do
  source    'vhost.conf.erb'
  variables(document_root: document_root)
  notifies  :restart, 'service[apache2]', :delayed
end

# Deshabilitar el sitio por defecto
execute 'disable-default-site' do
  command 'a2dissite 000-default.conf'
  only_if { ::File.exist?('/etc/apache2/sites-enabled/000-default.conf') }
  notifies :restart, 'service[apache2]', :delayed
end

# Habilitar el VirtualHost de WordPress
execute 'enable-wordpress-site' do
  command 'a2ensite wordpress.conf'
  not_if  { ::File.exist?('/etc/apache2/sites-enabled/wordpress.conf') }
  notifies :restart, 'service[apache2]', :delayed
end

# Habilitar mod_rewrite (necesario para permalinks de WordPress)
execute 'enable-mod-rewrite' do
  command 'a2enmod rewrite'
  not_if  { ::File.exist?('/etc/apache2/mods-enabled/rewrite.load') }
  notifies :restart, 'service[apache2]', :delayed
end
