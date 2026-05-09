require_relative '../../spec_helper'

describe 'mi_apache::default' do
  let(:document_root) { '/var/www/wordpress' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04') do |node|
      node.normal['wordpress'] = { 'document_root' => document_root }
    end.converge(described_recipe)
  end

  it 'instala el paquete apache2' do
    expect(chef_run).to install_package('apache2')
  end
end
