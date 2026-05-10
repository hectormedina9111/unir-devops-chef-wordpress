# Requiere gemas chefspec y chef instaladas en este Ruby (p. ej. gem install chefspec chef).

unless File.respond_to?(:exists?)
  class << File
    def exists?(path)
      exist?(path)
    end
  end
end

require 'chefspec'

RSpec.configure do |config|
  config.cookbook_path = File.expand_path('../chef/cookbooks', __dir__)
end
