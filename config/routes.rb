Rails.application.routes.draw do
  resources :expenses
  resources :events

  post "/login", to: "auth#login"
  post "/check_credentials", to: "auth#check_credentials"
  put "/password", to: "auth#password"

  get "/dashboard", to: "dashboard#show"

  get "/transactions", to: "transactions#index"
end
