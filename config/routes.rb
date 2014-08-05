Mytree::Application.routes.draw do

  devise_for :users
  get "link" => "links#fetch_links"
  post "link" => "links#create"
  post "link/:id" => "links#update"
  delete "link/:id" => "links#remove_link"
  root "mytree#index"

  get "category" => "category#fetch_categories"
  post 'category' =>  'category#create'

  get "friend" => "friend#fetch_friends"
  get "friend/:id" => "friend#fetch_friend_links"
end
