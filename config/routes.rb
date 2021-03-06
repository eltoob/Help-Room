Helproom::Application.routes.draw do

  get "getstatus/:id" => "getstatus#index"

  get "contact" => "home#contact"

  get "next" => "classroom#next"

  root :to => "home#index"

  get "about" => "home#about"

  post "pusher/auth"

  get "classroom/show"
  get "classroom/send_text/:recipient_id/:sender_id" => "classroom#send_text"
  post "classroom/send_text"
  get "c/:id" => "classroom#show"
  
  devise_for :users

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
  end

  devise_scope :user do
    get "/signup" => "devise/registrations#new"
  end
  get "/users" =>"home#index"
  get "/users/password" => "home#index"

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

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end


