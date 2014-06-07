Mytree::Application.routes.draw do

  devise_for :users
  get "link" => "links#fetch_links"
  post "link" => "links#create"
  delete "link/:id" => "links#destroy"
  root "mytree#index"

  get "category" => "category#fetch_categories"
  post 'category' =>  'category#create'
  
end
