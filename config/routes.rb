require 'api_constraints'

Rails.application.routes.draw do

  root 'logins#new'

  resources :admins

  get 'login', to: 'logins#new'
  post 'login', to: 'logins#create'
  delete 'logout', to: 'logins#destroy'

  get 'map', to: 'map#display'

  resources :tokens, except: :show

  resources :upload, except: :show

  get '/upload/:id', to: 'upload#make_current_map'

  resources :classrooms

  namespace :api, defaults: {format: :json} do

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      resources :map, only: [:index, :create]
      get 'map2', to: 'map#map2'

      resources :classrooms, only: [:index, :show]
      get '/classroom/:name', to: 'classrooms#show_by_name'
      get '/classroom_search/:query', to: 'classrooms#search_by_name'

      get '/tags/:id', to: 'tags#get_tags'
      post '/tags/:id', to: 'tags#save_for_classroom'
      delete '/tags/:id', to: 'tags#delete_tag'

      resources :corridors, only: :index
      get '/corridors2', to: 'corridors#corridors2'
      resources :stairs, only: :index
      get '/stair/:name', to: 'stairs#show_by_name'

      get :path, to: 'path#find'

      # Docs
      get :docs, to: 'docs#index'

    end

  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
