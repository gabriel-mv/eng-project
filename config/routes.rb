Rails.application.routes.draw do
  devise_for :users
	resources :users

  	root "pages#show", page: "home"

  	get 'auth/facebook/callback', to: 'sessions#create'
  	get 'auth/failure', to: redirect('/')
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
