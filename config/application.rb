require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tlstatus
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.force_ssl = true
    config.ssl_options = {
      redirect: {
        # workaround for discord not supporting our cert
        exclude: -> request { request.path =~ /^\/system\// }
      }
    }
    
    config.generators do |g|
      g.javascript_engine :js
    end
    
    config.session_store :cookie_store, expire_after: 14.days

    # TODO: change this to some async queue if too slow    
    config.active_job.queue_adapter = :inline
    
    Rails.application.routes.default_url_options[:host] = ENV['TLSTATUS_HOST']
    Rails.application.routes.default_url_options[:protocol] = 'https'
    config.action_controller.asset_host = "https://" + ENV['TLSTATUS_HOST']
  end
end
