BookSharingApp::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  match '/home/logout' , controller: 'home#logout', via: [:get, :post]
  get '/anonymous/index' , controller: 'anonymous#index'
  get '/books/own_books', controller: 'books#own_books'
  get '/books/shared_books', controller: 'books#shared_books'
  get '/books/borrowed_books', controller: 'books#borrowed_books'
  post '/borrowers/update_borrower', controller: 'borrowers#update_borrower'
  match '/books/create', controller: 'books#create', via: [:post]
  match '/borrowers/create', controller: 'borrowers#create', via: [:post]

  resources :books do
    get '/get_by_title/:title', to: 'books#get_by_title', :on => :collection
  end

  resources :search, only: [:index]
  resources :books, :home, :borrowers

  root 'books#own_books'


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
