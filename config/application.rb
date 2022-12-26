# frozen_string_literal: true

require_relative 'boot'

require 'rails'

require 'active_model/railtie'
# require 'active_job/railtie'
if ENV['COMPONENT_NAME'] == 'multimedia'
  require 'active_record/railtie'
  require 'active_storage/engine'
end
require 'action_mailer/railtie' if ENV['COMPONENT_NAME'] == 'authentication'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

require ENV.fetch('COMPONENT_NAME').to_s

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
    config.time_zone = 'UTC'
  end
end
