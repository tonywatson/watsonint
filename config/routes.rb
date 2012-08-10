Watsonint::Application.routes.draw do

  match '/about' => 'pages#about', :as => :about
  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout

  resource :user_session, :only => [:new, :create, :destroy]
  
  resources :images, :pages, :projects, :skilss
  
  root :to => 'pages#index'
  
end
