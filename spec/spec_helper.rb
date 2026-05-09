# Requiere gemas chefspec y chef instaladas en este Ruby (p. ej. gem install chefspec chef).
#
# Ruby 3.2+ eliminó File.exists?; Chef 17 lo sigue usando al evaluar recetas.
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
