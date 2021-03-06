Rails.application.routes.draw do
  resources :project, only: %i(index destroy)
  get "/poems", to: "project#poems", defaults: { format: 'png' }
  get "/diagram", to: "diagram#show", defaults: { format: 'png' }
  get "/unpublishable", to: "unpublishable#show", defaults: { format: 'png' }
  root to: "project#index"
end
