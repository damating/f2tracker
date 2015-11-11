Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'

  # Example of regular route:
  get 'signup' => 'players#signup'
  get 'new' => 'players#new'
  
  get 'players' => 'players#index'
  get 'destroy' => 'players#destroy'
  get 'statistics' => 'players#statistics'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :players

  get 'matches' => 'matches#index'
  get 'matches/new' => 'matches#new'
  resources :matches
end
