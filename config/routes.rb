Dayhomes::Application.routes.draw do
  devise_for :users
  devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  as :user do
    get "/login" => "devise/sessions#new"
  end
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
  end
  #get "organization/edit"

  #get "organization/show"

  get "billing/signup"
  put "billing/register"
  get "billing/welcome"
  get "billing/options"
  put "billing/upgrade"
  get "billing/extras"
  get "billing/get_coupon"
  put "billing/add"
  put "billing/activate"

  resources :organizations do
    resources :locations
    get :confirm_cancel
    post :cancel
  end

  resources :categories, :except => [:index, :show]
  resources :forums, :except => :index do
    resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'categories#index', :via => :get
  end

  root :to => 'pages#index'

  resources :searches
  match 'day_homes/deleted' => 'day_homes#deleted', :via=>:get,:as=>:deleted_day_homes
  resources :day_homes do
    resources :reviews
    resources :events
    match 'reactivate' => 'day_homes#reactivate', :as=>:reactivate, :via=>:put
    
    member do
      post :contact
      get :followup
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
      get :acknowledge
    end
  end
  resources :reviews
  
  # match 'login' => 'Devise::Sessions#create', :as => :login
  # match 'logout' => 'Devise::Sessions#destroy', :as => :logout
  resources :users
  # resources :user_sessions do
  #   collection do
  #     get :fb_connect
  #     get :fb_connect_callback
  #   end
  # end
  
  # match 'reset_password' => 'password_resets#new', :as => :reset_password
  # match 'reset_password_instructions/:id' => 'password_resets#edit', :as => :reset_password_instructions
  # match 'reset_password_instructions/:id/update' => 'password_resets#update', :as => :update_reset_password_instructions
  # match 'reset_password_admin/:id' => 'password_resets#admin_reset', :as => :reset_password_admin
  # resources :password_resets

  match 'email_dayhome' => 'day_homes#email_dayhome', :via => :post
  namespace :admin do
    resources :organizations
    match 'organizations/mass_update' => 'organizations#mass_update'    
  end
  namespace :admin do
    root :to => 'day_homes#index'
    
    resources :day_homes do
      match 'reactivate' => 'day_homes#reactivate', :as=>:reactivate, :via=>:put
      match 'obliterate' => 'day_homes#obliterate', :as=>:obliterate, :via=>:delete
    end
    match 'deleted_day_homes' => 'day_homes#deleted', :as=>:deleted_day_homes  , :via=>:get
    
    resources :users
    # resources :user_sessions
    
    
    match 'day_homes/mass_update' => 'day_homes#mass_update'    
    # match 'login' => 'user_sessions#new', :as => :login
    # match 'logout' => 'user_sessions#destroy', :as => :logout
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
