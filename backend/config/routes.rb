# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: {format: "json"} do
    resources :users
    post :auth, to: "user_token#create"
  end
  match "*path", to: "application#not_found", via: :all
end
