Watsonint::Application.routes.draw do
  resources :skills

  resources :images

  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout

  resource :session, :only => [:new, :create, :destroy]
    
  resources :pages
  resources :projects
  
  root :to => 'pages#index'
end
