Rails.application.routes.draw do

 get 'payments/new', as: "new_payment"

  post 'payments/create', as: "payments"

  resources :users, only: [:edit, :update, :show]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get '/newvidchat', to: 'streams#host', as: "host"
  get '/vidchat/:session_id', to: 'streams#join', as: "join"

  root 'welcome#index'

	get 'users/index'
  # get 'welcome/index'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
