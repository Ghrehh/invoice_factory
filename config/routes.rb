Rails.application.routes.draw do
  root 'static_pages#dashboard'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get "/download/:id", to: "invs#download", as: "inv_download"
  get "/download_group/:id", to: "groups#download", as: "group_download"
  
  get "/search_invoices/", to: "invs#search", as: "invoice_search"
  get "/dashboard_invoice/:id", to: "invs#dashboard_invoice", as: "dashboard_invoice"
  
  get "/render_recipient_form/:id", to: "invs#recipient_form", as: "recipient_form"
  get "/render_total_form/:id", to: "invs#total_form", as: "total_form"
  
  
  
  
  
  
  
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
  resources :toplines
  
  
end
