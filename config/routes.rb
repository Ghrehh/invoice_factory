Rails.application.routes.draw do
  root 'sessions#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get "/download/:id", to: "invs#download", as: "inv_download"
  get "/download_group/:id", to: "groups#download", as: "group_download"
  
  
  
  resources :invs do
    resources :lines
  end
  
  resources :lines do
    put :order, on: :collection
  end
  
  
  resources :users
  resources :groups
  
end
