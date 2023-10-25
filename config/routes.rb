require "sidekiq/web"

Rails.application.routes.draw do
  resource :notification, only: %i[new create]
  resource :validation, only: %i[create]

  root to: "notifications#new"

  mount Sidekiq::Web => "/sidekiq"
end
