ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'beta', 'beta'
end
Dayhomes::Application.routes.draw do

  devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'sessions', registrations: 'registrations' }
  mount Spree::Core::Engine, :at => '/shop'

  Spree::Core::Engine.add_routes do
      post '/paypal/express_subscription', :to=>"paypal#express_subscription", :as=> :paypal_subscription
      get '/paypal/subscribe', :to => "paypal#subscribe", :as => :subscribe_paypal
      get '/paypal/confirm', :to => "paypal#confirm", :as => :paypal_confirm
  end
  
  as :user do
    get "/login" => "devise/sessions#new"
  end
  devise_scope :user do
    get '/login', :to => "devise/sessions#new"
    get '/signup', :to => "devise/registrations#new"
    delete '/logout', :to => "devise/sessions#destroy"
  end

  # New Beta Routes
  #get  '/beta/list',      to: "beta#list" #Replaces New
  get  '/beta/dashboard', to: "beta#dashboard"
  resource :beta, except: [:new] do 
    get 'dayhomes/parents', :to=>"dayhomes#parents"
    get 'dayhomes/new', to: "beta#list"
    resources :dayhomes, except: [:new, :edit] do

        get 'overview'
        get 'photos'
        get 'location'
        get 'certifications'
        get 'spots'
        get 'plan'

        # AJAX
        post 'setTitle'
        post 'setSummary'
        post 'setDescription'
        post 'addPhoto'
        resources :photo, only: [:destroy], to: "dayhomes#removePhoto" do
          post 'setDefaultPhoto', to:"dayhomes#setDefaultPhoto"
          post 'setCaption', to:"dayhomes#setCaption"
        end
        post 'setAddress'
        post 'setCertifications'
    end
    # default route
    get ':province/:community/:dayhome_id', to:"dayhomes#show", as:"dayhome_by_location"
  end

  # Old Billing Routes
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
  get 'day_homes/deleted' => 'day_homes#deleted',:as=>:deleted_day_homes
  resources :day_homes do
    resources :reviews
    resources :events
    put 'reactivate' => 'day_homes#reactivate', :as=>:reactivate
    
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

  post 'email_dayhome' => 'day_homes#email_dayhome'
  namespace :admin do
    resources :organizations
    post 'organizations/mass_update' => 'organizations#mass_update'    
  end
  namespace :admin do
    root :to => 'day_homes#index'
    
    resources :day_homes do
      put 'reactivate' => 'day_homes#reactivate', :as=>:reactivate
      delete 'obliterate' => 'day_homes#obliterate', :as=>:obliterate
    end
    get 'deleted_day_homes' => 'day_homes#deleted', :as=>:deleted_day_homes   
    
    resources :users
    # resources :user_sessions
    
    
    post 'day_homes/mass_update' => 'day_homes#mass_update'    
    # match 'login' => 'user_sessions#new', :as => :login
    # match 'logout' => 'user_sessions#destroy', :as => :logout
  end
  
  # NOTE: This needs to stay at the very bottom always; since it's last priority that this gets matched.
  get '/:slug' => "day_homes#show", :as => :day_home_slug

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
