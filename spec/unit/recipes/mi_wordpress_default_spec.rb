require_relative '../../spec_helper'

describe 'mi_wordpress::default' do
  let(:document_root) { '/var/www/wordpress' }

  before do
    stub_command(/wget https:\/\/wordpress\.org/).and_return(true)
    stub_command(/tar -xzf \/tmp\/latest\.tar\.gz/).and_return(true)
    stub_command(/chown -R www-data:www-data/).and_return(true)
    stub_command(/wp core is-installed/).and_return(false)
    stub_command(/wp core install/).and_return(true)
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04') do |node|
      node.normal['wordpress'] = {
        'document_root' => document_root,
        'db_name' => 'wordpress_db',
        'db_user' => 'wp_user',
        'db_password' => 'wp_password',
        'db_host' => 'localhost',
        'url' => 'http://192.168.33.20',
        'title' => 'Blog de prueba',
        'admin_user' => 'admin',
        'admin_password' => 'admin123',
        'admin_email' => 'admin@example.com',
      }
    end.converge(described_recipe)
  end

  it 'genera wp-config.php desde plantilla' do
    expect(chef_run).to create_template("#{document_root}/wp-config.php").with(
      owner: 'www-data',
      group: 'www-data',
      mode: '0640'
    )
  end
end
