# frozen_string_literal: true

Rails.application.routes.draw do
  mount "#{ENV.fetch('COMPONENT_NAME').camelize}::Engine".constantize, at: "/#{ENV.fetch('COMPONENT_NAME')}"
  root to: 'main#root'
  get 'home', to: 'main#home'
end
