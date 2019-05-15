Rails.application.routes.draw do
  get '/my', to: 'images#my'
  resources :images, constraints: { id: /[\w\.]+/ }
  devise_for :users
	root to: "images#index"
end
