require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProyectoNinja
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.i18n.default_locale = :es
        
    Tmdb::Api.key("d4345c394b5a85b5749cfb819a8b2e01")
    Tmdb::Api.language("es")
    configuration = Tmdb::Configuration.new
    configuration.base_url
    configuration.secure_base_url
    configuration.poster_sizes
    configuration.backdrop_sizes
    configuration.profile_sizes
    configuration.logo_sizes
  end
end
