Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "front", to: "pages#front"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # TO VIEW ROUTES => http://localhost:3000/rails/info/routes

  # USER ROUTING
  resources :users, only: [:show, :index] do
    resources :recipes, only: [:index, :show] # => recipes linked to a user
    resources :shares, only: [:index] # A user can view all of their recipe shares
    resources :followers, only: [:index] # List followers for a user
  end

  # RECIPES ROUTING
  resources :recipes do # ALL CRUD ACTIONS
    # Nested => ingredients, tags, reviews and personal cookbook under recipes
    resources :ingredients, only: [:index, :show, :create, :new, :update, :destroy]
    resources :tags_recipes, only: [:create]
    resources :tags, only: [:index]
    resources :reviews, only: [:index, :show, :create]
    resources :shares, only: [:create, :index, :new] # If users can share recipes
      collection do
        get :cookbook
      end
    
      member do
        post :add_to_cookbook # Add a specific recipe to the user's cookbook
      end
  end

  # REVIEWS
  resources :reviews, only: [:show, :create, :update, :destroy]

  # SHARES => when a user wants to share a recipe
  resources :shares, only: [:index, :show, :create]

  # INGREDIENTS => manage ingredients data
  resources :ingredients, only: [:index, :show, :create, :update, :destroy]

  # TAGS => tags to assign to a recipe
  resources :tags, only: [:index, :show, :create, :update, :destroy]

  # FOLLOWER_USERS => to assign following, followed or un-followed to a user
  resources :followers_users, only: [:create, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'dashboard', to: 'pages#dashboard'

  # Defines the root path route ("/")
  # root "posts#index"
end
