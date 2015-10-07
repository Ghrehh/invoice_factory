Rails.application.routes.draw do
  root 'sessions#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get "/download/:id", to: "invs#download", as: "inv_download"
  
  get "/groups/:id", to: "groups#change_group", as: "group_change"
  
  resources :invs do
    resources :lines
  end
  
end
