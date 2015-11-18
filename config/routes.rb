Rails.application.routes.draw do
  root 'static_pages#tutorial'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get "/download/:id", to: "invs#download", as: "inv_download"
  get "/download_group/:id", to: "groups#download", as: "group_download"
  
  get "/search_invoices/", to: "invs#search", as: "invoice_search"
  
  post "/tutorial_1/", to: "users#tutorial_1", as: "tutorial_1"
  
  
  
  
  resources :invs do
    resources :lines
  end
  
  resources :lines do
    put :order, on: :collection
  end
  
  resources :toplines do
    put :order, on: :collection
  end
  
  
  resources :users 
  resources :groups
  resources :coverimages
  
  
end
