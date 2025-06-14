Rails.application.routes.draw do
  root "sessions#index"

  resources :tasks do
    resources :offers, only: [ :new, :create, :edit, :destroy ]
    patch "offers/:id", to: "offers#update"
    patch "offers/:id/accept", to: "offers#accept", as: "accept"
    patch "offers/:id/decline", to: "offers#decline", as: "decline"
    patch "offers/:id/cancel", to: "offers#cancel", as: "cancel"
    get "review", to: "reviews#new", as: "review"
  end

  resource :session
  get "login", to: "sessions#new", as: "login"

  resources :passwords, param: :token

  resources :users, except: [ :update, :destroy ] do
    get "work-overview", to: "users#work_overview"
    get "active-tasks", to: "users#user_active_tasks"
    get "finished-tasks", to: "users#user_finished_tasks"
  end

  get "register", to: "users#new", as: "register"

  get "profile", to: "users#profile"
  get "edit_profile", to: "users#edit"
  patch "profile/update", to: "users#update", as: "update_profile"
  get "my-offers", to: "users#my_offers"

  resources :reviews, only: [ :create ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
