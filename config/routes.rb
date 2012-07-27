Watsonint::Application.routes.draw do
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout

  resource :session, :only => [:new, :create, :destroy]
    
  resources :pages
  resources :projects
  
  root :to => 'pages#index'
end
