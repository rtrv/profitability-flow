require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProfitabilityFlow
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.autoload_paths += %W(#{config.root}/app/models/accounts)
  end
end
