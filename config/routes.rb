Rails3Saas::Application.routes.draw do
  devise_for :users

  as :user do
    get 'login', :to => 'devise/sessions#new', :as => 'new_user_session'
    get 'logout', :to  => 'devise/sessions#destroy', :as => 'destroy_user_session'
    get 'signup', :to => 'devise/registrations#new', :as => 'new_user_registration'
  end

  resource :accounts

  map.dashboard "/dashboard", :controller => "dashboard", :action => "index"
  
  root :to => 'dashboard#index'
end
