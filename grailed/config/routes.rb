Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', :omniauth_callbacks => "omniauth_callbacks" }

  get 'blacklist/theblacklist'
  get 'admin/admins'
  get 'profile/userprofile'
  get 'dumpster/thedumpster'
  get 'users/admins'
  get 'users/edit'
  

  get 'home/start' , to: 'home#start'
  #root "home#logIn"
  root "home#start"
  
  #get  "thedumpster" , to :"dumpster#thedumpster"
  resources :flag_pos
  resources :votes
  resources :users
  resources :comments
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
