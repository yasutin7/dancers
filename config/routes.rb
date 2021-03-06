Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/signup' => 'users#create'
  get '/signup' => 'users#new'
  resources :users
  root to: 'posts#index'
  resources :posts
  get '/top' => 'home#top'

  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:show, :create, :index]
  mount ActionCable.server => '/cable'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy, :index]
  end
end
