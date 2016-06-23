Rails.application.routes.draw do
  resources :project, only: %i(index destroy)
  get "/poems", to: "project#poems", defaults: { format: 'png' }
  root to: "project#index"
end
