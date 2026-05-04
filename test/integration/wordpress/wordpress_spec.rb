# Se verifica que el servicio de Apache este instalado, habilitado y en ejecucion
describe service('apache2') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
end

# Se verifica que el archivo de configuracion de Apache para WordPress exista
describe file('/etc/apache2/sites-enabled/wordpress.conf') do
    it { should exist }
end

# Se verifica que el servicio de MySQL este instalado, habilitado y en ejecucion
describe service('mysql') do 
    it { should be_installed }
    it { should be_enabled }
    it { should be_running } 
end

# Se verifica que la base de datos de WordPress y sus credenciles existan en MySQL
describe mysql_session('wp_user','wp_password').query('SHOW DATABASES;') do
    its('stdout') { should match /wordpress_db/ }
end

# Se verifica que la pagina de inicio de WordPress este disponible y respondiendo correctamente
describe http('http://localhost:80') do
  its('status') { should cmp 200 }
end

