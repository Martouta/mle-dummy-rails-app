# frozen_string_literal: true

COMPONENT_PATH = File.expand_path("../../components/#{ENV.fetch('COMPONENT_NAME')}", __dir__)

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', COMPONENT_PATH)

require 'bundler/setup' if File.exist?(ENV.fetch('BUNDLE_GEMFILE'))
$LOAD_PATH.unshift File.expand_path('lib', COMPONENT_PATH)
