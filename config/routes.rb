Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :groups do
    resources :members, only: [:create, :index, :edit] do
      resources :member_rewards, only: [:index, :update]
      resources :member_punishments, only: [:index, :update]
    end
    resources :rewards, only: [:index, :update]
    resources :punishments, only: [:index, :update]
    resources :tasks, only: [:new, :create]
    # resources :messages, only: [:show, :create]
  end

  resources :progresses, only: [:edit, :update]
  resources :members, only: [:show, :destroy, :edit]


  resources :chats, only: [:index, :show] do
    resources :messages, only: [:index, :show, :create]
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
