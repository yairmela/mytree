Mytree::Application.routes.draw do

  get "links" => "links#show_all"
  post "links" => "links#create"
  delete "links/:id" => "links#delete"
  root "mytree#index"
  
end
