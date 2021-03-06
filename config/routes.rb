Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: { registrations: "user_registrations" }

  resources :products do
    resources :comments
  end
  resources :users
  resources :orders, only: [:index, :show, :new, :create]

  resources :payments, only: [:new, :create]
  
  #resources for sitemap
  resources :sitemaps, :only => :index


  mount ActionCable.server => '/cable'

  post 'payments/create'

  get 'static_pages/about'

  get 'static_pages/contact'
  post 'static_pages/thank_you'

  get 'static_pages/index'

  get 'index', to: 'orders#index'

  #add route for sitemap
  get 'sitemap.xml' => 'sitemaps#index', :format => 'xml', :as => :sitemap

  root 'static_pages#landing_page'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
