ActionController::Routing::Routes.draw do |map|
  map.resources :userblocks


	map.connect '/keyword_tweets/hashtag_datail', :controller => 'keyword_tweets', :action => 'hashtag_detail'

  map.resources :comments

  map.resources :types

  map.resources :user_details

  map.root :controller => 'home'
  map.resources :keyword_urls
  map.tweeturl '/:tweetid/tweets', :controller => 'keyword_urls', :action => 'show'
	map.tweetuser '/railstwits/users', :controller => 'keyword_tweets', :action => 'tweetuser'
	map.user_detail '/railstwits/user/:user', :controller => 'keyword_tweets', :action => 'user_detail'
	map.websites '/websites', :controller => 'keyword_tweets', :action => 'websites'
	map.website_detail '/website/:id', :controller => 'keyword_tweets', :action => 'website_detail'
	map.spam_user '/spam/user', :controller => 'keywords', :action => 'spam_user'
	map.connect '/hashtag/:name', :controller => 'keyword_tweets', :action => 'hashtag'

  map.resources :keyword_tweets

  map.resources :keywords

    map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
 		map.user '/users/create', :controller => 'users', :action => 'create'
    map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
    map.signup '/signup', :controller => 'users', :action => 'new'
    map.login  '/login', :controller => 'sessions', :action => 'new'
    map.logout '/logout', :controller => 'sessions', :action => 'destroy'
    map.account '/myaccount', :controller => 'users', :action => 'show'
    map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
    map.reset_password '/reset_password/:id', :controller => 'users', :action => 'reset_password'   
		map.connect '/user/:login', :controller => 'users', :action => 'show'
    map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

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
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
