SniptMonkey::Application.routes.draw do
  
  resources :snippets do
    member do
      get 'delete_resource'
      get 'share_resource'
      post 'add_snippet_comment'
      post 'update_snippet'
      get 'show_comments'
    end
  end
  match '/search', :to => "snippets#search", :via => :post
  match '/filter', :to => "snippets#filter", :via => [:post, :get]
  match '/about_us', :to => "snippets#about_us", :via => :get
  match '/privacy_policy', :to => "snippets#privacy_policy", :via => :get
  match '/license', :to => "snippets#license", :via => :get
  devise_for :users, :controllers => { :sessions => "users/sessions" , :registrations => "users/registrations", :omniauth_callbacks => "omniauth_callbacks", :activities => "users/activities"}
 devise_scope :user do
   post '/users/upload_avatar' => 'users/activities#upload_avatar'
   post '/users/change_profile_info' => 'users/activities#change_profile_info'
   post '/users/change_password' => 'users/activities#change_password'
   get '/users/profile' => 'users/activities#view_profile'
   get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
   get "users/sign_out", :to => "users/sessions#destroy"
   match "/user/sign_up", :to => "users/registrations#sign_up", :via => :post
   match "/user/sign_up_form", :to => "users/registrations#new"
   get "forgot_password", :to => "users/sessions#forgot_password"
   post "recover_password", :to => "users/sessions#recover_password"
   match "/update_password/:id", :to => "users/sessions#update_password", :via => :post, :as => :update_password
   match "/users/edit_password/:id" => "users/sessions#edit_password", :via => :get, :as => :edit_password
   match "/snippet_monkey/users/activate_account/(:confirmation_token)" => "users/registrations#activate_account", :via => :get, :as => :user_account_activation
   post "verify_account_confirmation", :to => "users/sessions#verify_account_confirmation"
   post "user/recover_password", :to => "users/activities#recover_password"
   get "user/edit_password_via_recovery", :to => "users/activities#edit_password_via_recovery", :as => :edit_password_via_recovery
   post "user/update_password_via_recovery", :to => "users/activities#update_password_via_recovery"
   get "/user_avatars/:image.:format", :to => "users/activities#render_avatar_image"
 get "/maintainance.html", :to => "users/activities#maintainance"
 get "/page_not_found.html", :to => "users/activities#page_not_found"
 end
 match 'snippet/share_count', :to => "snippets#resource_share_count", :via => :post
 root :to => 'snippets#index'
 match '*a' => 'snippets#index'
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
