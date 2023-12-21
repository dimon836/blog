# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'

  resources :articles do
    resources :comments
  end
end
