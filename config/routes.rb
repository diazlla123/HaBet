Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :groups do
    resources :members, only: [:create, :index]
    resources :rewards, only: [:index]
    resources :punishments, only: [:index]
    resources :tasks, only: [:new, :create]
  end

  resources :progresses, only: [:edit, :update]
  # Defines the root path route ("/")
  # root "posts#index"
end
