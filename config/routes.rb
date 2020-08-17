Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "registrations"}
  root to: 'pages#home'
  get '/user' => "posts#index", as: :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :profiles do
    resources :user_diseases, only: :create
    resources :friendships, only: :create
    resources :chats, only: :create
  end

  namespace :user do
    resources :friendships, only: [:index, :destroy, :update]
  end

  resources :chats, only: :show do
    resources :messages, only: :create
  end

  resources :posts
  resources :user_diseases, only: :destroy
  resources :friendships, only: [:destroy, :update]
  resources :chats, only: :show
end
