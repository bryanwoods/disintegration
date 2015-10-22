Rails.application.routes.draw do
  resources :project, only: %i(index destroy)
  root to: "project#index"
end
