Rails.application.routes.draw do
  devise_for :users
  root to: "pages#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # TO VIEW ROUTES => http://localhost:3000/rails/info/routes
  
  # USER ROUTING
  resources :users, only: [:show, :index] do
    resources :recipes, only: [:index, :show]
    resources :shares, only: [:index] # A user can view all of their recipe shares
    resources :followers, only: [:index] # List followers for a user
  end

  # RECIPES ROUTING
  resources :recipes do # ALL CRUD ACTIONS
    # Nested => ingredients, tags, and reviews under recipes
    resources :ingredients, only: [:index, :show]
    resources :tags, only: [:index]
    resources :reviews, only: [:index, :show, :create]
    # resources :shares # If users can share recipes
  end

  # REVIEWS
  resources :reviews, only: [:show, :create, :update, :destroy]

  # SHARES => when a user wants to share a recipe
  resources :shares, only: [:index, :show, :create, :destroy]

  # INGREDIENTS => manage ingredients data
  resources :ingredients, only: [:index, :show, :create, :update, :destroy]

  # TAGS => tags to assign to a recipe
  resources :tags, only: [:index, :show, :create, :update, :destroy]

  # FOLLOWER_USERS => to assign following, followed or un-followed to a user
  resources :followers_users, only: [:create, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
