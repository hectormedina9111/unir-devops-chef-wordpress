require_relative '../../spec_helper'

describe 'mi_php::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04') do |node|
      node.normal['wordpress'] = { 'document_root' => '/var/www/wordpress' }
    end.converge('mi_apache::default', described_recipe)
  end

  it 'instala el paquete php' do
    expect(chef_run).to install_package('php')
  end
end
