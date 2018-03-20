Rails.application.routes.draw do
  root 'pages#home'
  resources :books
  resources :users, except: [:new]
  get 'signup', to: "users#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'login', to: "sessions#new"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/client/index', to:'client#index', foo: 'bar', magic: 'calabria'
  get '/client/xedni', to:'client#xedni'
end
