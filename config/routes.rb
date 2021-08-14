Rails.application.routes.draw do
  resources :events

  post "/login", to: "auth#login"
  put "/password", to: "auth#password"

  get "/dashboard", to: "dashboard#show"
end
