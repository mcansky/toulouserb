ActionController::Routing::Routes.draw do |map|
	map.connect 'events/rss.xml', :controller => 'events', :action => 'rss'
  map.connect 'blog_posts/rss.xml', :controller => 'blog_posts', :action => 'rss'
	map.connect 'posts/doc/:id', :controller => 'posts', :action => 'file'
  map.resources :user_sessions, :posts, :projects, :partners
  map.resources :users, :blog_posts, :pages, :events
  # The priority is based upon order of creation: first created -> highest priority.

	map.login "login", :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"
	map.signup "signup", :controller => "users", :action => "new"
	map.about "about", :controller => "application", :action => "about"

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
  
  # route to get pages using their title :
  #map.connect 'pages/:title', :controller => 'pages', :action => 'show'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "application"
  #map.root :controller => "pages", :action => "show", :id => 1

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
