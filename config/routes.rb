Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks
  resource :session
  resources :passwords, param: :token
  resources :users

  get "users/:user_id/tasks/:task_id", to: "tasks#user_task", as: "user_task"
  get "profile", to: "users#profile"
  get "profile/tasks/:id", to: "tasks#my_task", as: "my_task"
  get "profile/tasks/:id/edit", to: "tasks#edit", as: "edit"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
