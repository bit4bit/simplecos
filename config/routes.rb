
Simplecos::Application.routes.draw do




  resources :sip_clients

  resources :trunks

  resources :sip_profiles

  resources :client_cash_plans do
    get "clone"
  end

  namespace :consumers do resources :request_cashes end

  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  namespace :consumers do
    devise_for :clients, :controllers => {:registrations => 'consumers/registrations', :sessions => 'consumers/sessions'}
    resources :sip_clients
    get "consumer/index"
    get "cdr/index"
    get "cdr/send_cdr", :as => :cdr_send
  end
  
  resources :freeswitches 
  match '/dialplan' => 'freeswitches#dialplan', :via => [:post,:get], :format => 'xml'
  match '/directory' => 'freeswitches#directory', :via => [:post,:get], :format => 'xml'
  match '/configuration' => 'freeswitches#configuration', :via => [:post,:get], :format => 'xml'
  match '/bill/:client' => 'freeswitches#bill', :via => [:post, :get], :format => 'xml', :as => :bill
  match '/xml_cdr' => 'freeswitches#xml_cdr', :via => :post, :format => 'xml', :as => :xml_cdr
  

  resources :public_cash_plans

  resources :public_carriers

  resources :client_cashes do
    delete 'approved'
    delete 'dismiss'
  end
  

  resources :clients

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
  root :to => 'freeswitches#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
