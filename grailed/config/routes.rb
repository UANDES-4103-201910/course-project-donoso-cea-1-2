Rails.application.routes.draw do
  resources :flag_pos
  resources :votes
  resources :users
  resources :comments
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
