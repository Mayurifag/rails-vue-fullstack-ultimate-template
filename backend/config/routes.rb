# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: {format: "json"} do
    namespace :users do
      post "signin", controller: :signin, action: :create
      post "signup", controller: :signup, action: :create
      post "refresh", controller: :refresh, action: :create
      delete "signin", controller: :signin, action: :destroy
      get "whoami", controller: :users

      resources :password_resets, only: [:create] do
        collection do
          get ":token", action: :show, as: :show
          patch ":token", action: :update
        end
      end
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  match "*path", to: "application#not_found", via: :all
end
