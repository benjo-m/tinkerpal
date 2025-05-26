Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks do
    resources :offers, only: [ :new, :show, :create, :edit, :destroy ]
    patch "offers/:id", to: "offers#update"
    patch "offers/:id/accept", to: "offers#accept", as: "accept"
    patch "offers/:id/decline", to: "offers#decline", as: "decline"
    patch "offers/:id/cancel", to: "offers#cancel", as: "cancel"
    get "review", to: "reviews#new", as: "review"
  end

  resource :session
  resources :passwords, param: :token
  resources :users, except: [ :edit, :update, :destroy ]

  get "profile", to: "users#profile"
  patch "profile/update", to: "users#update", as: "update_profile"
  get "my-offers", to: "users#my_offers"
  get "my-work-overview", to: "users#my_work_overview"
  
  resources :reviews, only: [ :create ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
