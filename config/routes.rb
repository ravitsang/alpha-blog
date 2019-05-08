Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  get 'about', to: 'pages#about' #pages = controller about = view


  resources :articles

  # get 'greeting/night', to: 'greeting#night'

  get 'signup', to: 'users#new' #signup = routes ,users = controller, users = view , new = view file
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]


end
