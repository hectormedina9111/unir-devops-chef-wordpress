require_relative '../../spec_helper'

describe 'mi_mysql::default' do
  before do
    stub_command(/mysql -uroot/).and_return(false)
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04') do |node|
      node.normal['wordpress'] = {
        'db_name' => 'wordpress_db',
        'db_user' => 'wp_user',
        'db_password' => 'wp_password',
      }
    end.converge(described_recipe)
  end

  it 'instala el servidor MySQL (mysql-server)' do
    expect(chef_run).to install_package('mysql-server')
  end
end
