Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'greeting#morning'

  get 'night', to: 'greeting#night' 

  resources :articles
  
  # get 'greeting/night', to: 'greeting#night' 
	
end	
			