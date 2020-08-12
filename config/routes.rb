Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :profiles do
    resources :user_diseases, only: :create
    resources :friendships, only: :create
  end

  resources :posts, only: [:show, :new, :index, :create, :destroy, :update]
  resources :friendships, only: [:destroy, :update]
  resources :user_diseases, only: :destroy
end
