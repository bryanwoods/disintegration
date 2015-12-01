Rails.application.routes.draw do
  resources :project, only: %i(index destroy)
  get "/poems", to: "project#poems"
  root to: "project#index"
end
