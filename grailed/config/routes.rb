Rails.application.routes.draw do
  resources :flag_posts
  devise_for :users, controllers: { registrations: 'registrations', :omniauth_callbacks => "omniauth_callbacks" }

  get 'blacklist/theblacklist'
  get 'admin/admins'
  get 'profile/userprofile'

  get 'users/admins'
  get 'users/edit'
  get 'users/blacklist'
  get 'posts/dumpster'
  get 'users/new_admin'

  
  #post '/upvote' => 'votes#create', as: :upvote_create
  #post '/downvote' => 'votes#dislike', as: :downvote_create

  get 'home/start' , to: 'home#start'

  #root "home#logIn"
  root "home#start"
  
  #get  "thedumpster" , to :"dumpster#thedumpster"
  resources :users
  resources :comments

  resources :posts do
	resources :likes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
