Rails.application.routes.draw do
  get 'blacklist/theblacklist'
  get 'admin/admins'
  get 'profile/userprofile'
  get 'dumpster/thedumpster'

  get 'home/start' , to: 'home#start'
  root "home#logIn"
  #get  "thedumpster" , to :"dumpster#thedumpster"
  resources :flag_pos
  resources :votes
  resources :users
  resources :comments
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
