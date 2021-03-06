LaunchGator::Application.routes.draw do
  
  resources :contact_us,:only=>[:new,:create]


  match '/:id' => 'invites#referral', :constraints => {:id => /[a-zA-Z]{3}[0-9]{3}/}

  resources :invites,:only=>[:create] do
    member do
      get 'referral'      
    end
  end  

  resources :sites, :only=>[:index,:edit,:update]   do
    member do
      get 'view'
    end  
    resources :invites,:only=>[:index]
  end 


  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :users, :only => [:index] do
    collection do
      get 'home'
    end    
    
  end

  match 'check_user' => 'users#check_user', :as => :check_user
  match 'terms'=>'pages#terms',:as=>:terms
  match 'contact' => 'contact_us#new',:as=>:contact
  match 'about' => 'pages#about', :as => :about
  match 'terms'=>'pages#terms',:as=>:terms
  match 'privacy_policy'=>'pages#privacy_policy',:as=>:privacy_policy
    
  match 'auth/failure', to: redirect('/')
  
  root :to => 'users#home'

  constraints(Subdomain) do
    root :to => 'sites#view'
  end
  
  
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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
