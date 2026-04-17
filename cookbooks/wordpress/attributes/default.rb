# Directorio raíz donde se desplegará WordPress
default['wordpress']['document_root'] = '/var/www/wordpress'

# Base de datos
default['wordpress']['db_name']     = 'wordpress_db'
default['wordpress']['db_user']     = 'wp_user'
default['wordpress']['db_password'] = 'wp_password'
default['wordpress']['db_host']     = 'localhost'

# URL del sitio (puede sobreescribirse desde el Vagrantfile)
default['wordpress']['url'] = 'http://192.168.33.10'

# Configuración inicial del sitio WordPress
default['wordpress']['title']          = 'FinTech Solutions, S.A'
default['wordpress']['admin_user']     = 'admin'
default['wordpress']['admin_password'] = 'admin123'
default['wordpress']['admin_email']    = 'admin@example.com'
