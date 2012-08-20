Watsonint::Application.routes.draw do
  
  get '/robots.txt' => 'pages#robots'

  match '/about' => 'pages#about', :as => :about
  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout

  resource :user_session, :only => [:new, :create, :destroy]
  
  resources :images, :pages, :projects, :skills
  
  root :to => 'pages#index'
  
end
