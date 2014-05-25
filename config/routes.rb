Mytree::Application.routes.draw do

  devise_for :users
  get "links" => "links#show_all"
  post "links" => "links#create"
  delete "links/:id" => "links#destroy"
  root "mytree#index"
  
end
