Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments
  end

  resolve("article") { [:articles] }
end
