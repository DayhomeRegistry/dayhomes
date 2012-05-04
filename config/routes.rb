Dayhomes::Application.routes.draw do
  resources :categories, :except => [:index, :show]
  resources :forums, :except => :index do
    resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'categories#index', :via => :get
  end

  root :to => 'pages#index'

  resources :searches
  resources :day_home_signup_requests
  resources :day_homes do
    resources :reviews
    resources :events
    
    member do
      post :contact
    end

    member do
      get 'calendar'
    end
  end
  resources :pages do
    collection do
      get :about
      get :privacy
      get :pricing
    end
  end
  resources :reviews
  
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  resources :users
  resources :user_sessions do
    collection do
      get :fb_connect
      get :fb_connect_callback
    end
  end
  
  match 'reset_password' => 'password_resets#new', :as => :reset_password
  match 'reset_password_instructions/:id' => 'password_resets#edit', :as => :reset_password_instructions
  match 'reset_password_instructions/:id/update' => 'password_resets#update', :as => :update_reset_password_instructions
  resources :password_resets

  match 'email_dayhome' => 'day_homes#email_dayhome', :via => :post

  namespace :admin do
    root :to => 'day_homes#index'
    
    resources :day_homes
    resources :users
    resources :user_sessions
    
    match 'login' => 'user_sessions#new', :as => :login
    match 'logout' => 'user_sessions#destroy', :as => :logout
  end
  
  # NOTE: This needs to stay at the very bottom always; since it's last priority that this gets matched.
  match '/:slug' => "day_homes#show", :as => :day_home_slug

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
