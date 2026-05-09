require_relative '../../spec_helper'

describe 'mi_propia::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04').converge(described_recipe)
  end

  it 'ejemplo de un test que pasa' do
    expect(1).to eq(1)
  end

  it 'fallo deliberado (1 no es 0)' do
    expect(1).to eq(0)
  end

end
