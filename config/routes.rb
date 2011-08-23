Startup::Application.routes.draw do
  
  devise_for :users, :path => 'users', 
            :controllers => { :omniauth_callbacks => 'authentications', :sessions => 'sessions',
                              :passwords => 'passwords', :registrations => 'registrations' },
            :skip => [:sessions, :passwords] do
    # registrations
    get 'sign_up' => 'registrations#new', :as => :new_user_registration
    
    #sessions          
    get 'sign_in' => 'sessions#new', :as => :new_user_session
    post 'sign_in' => 'sessions#create', :as => :user_session 
    get 'sign_out' => 'sessions#destroy', :as => :destroy_user_session
    
    #omniauth
    match 'users/auth/:provider/callback' => 'authentications#create', :as => :user_omniauth_callback
  end
  
  resources :authentications
  
  get 'home' => 'users#home', :as => :home
  
  root :to => 'index#index'

end
