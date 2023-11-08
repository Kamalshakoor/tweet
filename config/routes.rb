Rails.application.routes.draw do
  resources :twets
  root 'twets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
