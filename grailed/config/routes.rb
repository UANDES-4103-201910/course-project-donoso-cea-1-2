Rails.application.routes.draw do
  get 'blacklist/theblacklist'
  get 'admin/admins'
  get 'profile/userprofile'
  get 'dumpster/thedumpster'
  root "home#start"
  #get  "thedumpster" , to :"dumpster#thedumpster"
  resources :flag_pos
  resources :votes
  resources :users
  resources :comments
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
