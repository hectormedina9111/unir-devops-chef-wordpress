document_root = node['wordpress']['document_root']
db_name       = node['wordpress']['db_name']
db_user       = node['wordpress']['db_user']
db_password   = node['wordpress']['db_password']
db_host       = node['wordpress']['db_host']
wp_url        = node['wordpress']['url']
wp_title      = node['wordpress']['title']
admin_user    = node['wordpress']['admin_user']
admin_pass    = node['wordpress']['admin_password']
admin_email   = node['wordpress']['admin_email']

# Descargar WordPress
execute 'download-wordpress' do
  command 'wget https://wordpress.org/latest.tar.gz -P /tmp/'
  creates '/tmp/latest.tar.gz'
  action  :run
end

# Extraer WordPress en el document root
execute 'extract-wordpress' do
  command "tar -xzf /tmp/latest.tar.gz -C #{document_root} --strip-components=1"
  creates "#{document_root}/wp-login.php"
  action  :run
end

# Ajustar permisos del document root
execute 'fix-wordpress-permissions' do
  command "chown -R www-data:www-data #{document_root}"
  action  :run
end

# Generar wp-config.php desde template
template "#{document_root}/wp-config.php" do
  source    'wp-config.php.erb'
  owner     'www-data'
  group     'www-data'
  mode      '0640'
  variables(
    db_name:     db_name,
    db_user:     db_user,
    db_password: db_password,
    db_host:     db_host,
    wp_url:      wp_url
  )
  action :create
end

# Descargar WP-CLI
remote_file '/usr/local/bin/wp' do
  source  'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  mode    '0755'
  action  :create_if_missing
end

# Instalar WordPress (configuración inicial del sitio)
execute 'install-wordpress' do
  command <<~CMD
    wp core install \
      --path=#{document_root} \
      --url=#{wp_url} \
      --title='#{wp_title}' \
      --admin_user='#{admin_user}' \
      --admin_password='#{admin_pass}' \
      --admin_email='#{admin_email}' \
      --allow-root
  CMD
  not_if  "wp core is-installed --path=#{document_root} --allow-root"
  environment 'PATH' => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  action  :run
end
