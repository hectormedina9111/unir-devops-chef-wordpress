db_name     = node['wordpress']['db_name']
db_user     = node['wordpress']['db_user']
db_password = node['wordpress']['db_password']

# Instalar MySQL Server
package 'mysql-server' do
  action :install
end

# Arrancar y habilitar el servicio MySQL
service 'mysql' do
  action [:enable, :start]
end

# Crear la base de datos de WordPress
execute 'create-wordpress-database' do
  command "mysql -uroot -e \"CREATE DATABASE IF NOT EXISTS #{db_name}\""
  not_if  "mysql -uroot -e \"SHOW DATABASES\" | grep #{db_name}"
  action  :run
end

# Crear el usuario de WordPress
execute 'create-wordpress-user' do
  command "mysql -uroot -e \"CREATE USER IF NOT EXISTS '#{db_user}'@'localhost' IDENTIFIED BY '#{db_password}'\""
  not_if  "mysql -uroot -e \"SELECT User FROM mysql.user\" | grep #{db_user}"
  action  :run
end

# Otorgar privilegios al usuario
execute 'grant-wordpress-privileges' do
  command "mysql -uroot -e \"GRANT ALL PRIVILEGES ON #{db_name}.* TO '#{db_user}'@'localhost'; FLUSH PRIVILEGES;\""
  not_if  "mysql -uroot -e \"SHOW GRANTS FOR '#{db_user}'@'localhost'\" | grep #{db_name}"
  action  :run
end
