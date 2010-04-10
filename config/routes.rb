ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  map.resources :configurations do |c|
    c.resources :examples
  end
  map.configuration_example_release 'configurations/:configuration_id/examples/:id/release/:version', :controller => 'examples', :action => 'show', :requirements => { :version => /.*/ }
  
  map.resources :examples
  map.resources :platforms
  map.resources :browsers
  map.resources :releases
  map.resources :tests
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.fail_log 'fails', :controller => 'tests', :action => 'fails'
  map.fail_log_by_platform 'fails/platform/:platform_id', :controller => 'tests', :action => 'fails'
  map.fail_log_by_platform 'fails/browser/:browser_id', :controller => 'tests', :action => 'fails'
  map.fail_log_by_release 'fails/release/:version', :controller => 'tests', :action => 'fails', :requirements => { :version => /.*/ }
  map.fail_log_by_configuration 'fails/platform/:platform_id/browser/:browser_id/release/:version', :controller => 'tests', :action => 'fails', :requirements => { :version => /.*/ }
    
  map.root :controller => "user_sessions", :action => "new"


  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
