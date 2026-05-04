name 'chef-wordpress'
default_source :supermarket

# Configurar la ruta en donde se encuentran los Cookbooks
default_source :chef_repo, './chef/cookbooks'

# Asignar los atributos por defecto para el Cookbook de WordPress
default['wordpress']['url'] = 'http://localhost'
default['wordpress']['document_root'] = '/var/www/wordpress'
default['wordpress']['db_name'] = 'wordpress_db'
default['wordpress']['db_user'] = 'wp_user'
default['wordpress']['db_password'] = 'wp_password'
default['wordpress']['db_host'] = 'localhost'
default['wordpress']['title'] = 'TechOps Solutions, S.A'
default['wordpress']['admin_user'] = 'admin'
default['wordpress']['admin_password'] = 'admin123'
default['wordpress']['admin_email'] = 'admin@example.com'

# Ejecutar el Cookbook principal
run_list 'principal::default'

