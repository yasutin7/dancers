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
  get '/about' => 'home#about'
  resources :relationships, only: [:create, :destroy]
  
  
  resources :users do
    member do 
      get :following, :followers
    end
  end

end
