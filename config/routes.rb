Startup::Application.routes.draw do
  
  devise_for :users, :path => 'users', 
            :controllers => { :omniauth_callbacks => 'omniauth_callbacks', :sessions => 'sessions' },
            :skip => [:registrations, :passwords, :sessions] do
    get 'sign_in' => 'sessions#new', :as => :new_user_session
    post 'sign_in' => 'sessions#create', :as => :user_session 
    get 'sign_out' => 'sessions#destroy', :as => :destroy_user_session
    
    match '/users/auth/:provider/callback' => 'omniauth_callbacks#handle', :as => :user_omniauth_callback
  end

end
