Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks do
    resources :offers, only: [ :new, :create ]
  end

  resource :session
  resources :passwords, param: :token
  resources :users, except: [ :edit, :update, :destroy ]

  get "profile", to: "users#profile"
  patch "profile/update", to: "users#update", as: "update_profile"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
