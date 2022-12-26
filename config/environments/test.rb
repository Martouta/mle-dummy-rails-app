# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.cache_classes = true

  config.eager_load = false

  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.seconds.to_i}"
  }

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false

  config.active_job.queue_adapter = :test

  if ENV['COMPONENT_NAME'] == 'authentication'
    config.action_mailer.delivery_method = :test
    config.action_mailer.default_url_options = { host: 'localhost', port: '3000' }
  end

  if ENV['COMPONENT_NAME'] == 'multimedia'
    config.active_storage.service = :test
    config.autoloader = :classic
    routes.default_url_options[:host] = 'localhost:3000'
  end

  config.active_support.deprecation = :stderr
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
end
