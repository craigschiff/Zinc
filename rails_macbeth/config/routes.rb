Rails.application.routes.draw do
  root 'root#index'
  # resources :characters
  resources :versions, only: [:index, :new, :create, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
