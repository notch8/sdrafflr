Rails.application.routes.draw do
  root 'raffles#index'
  resources 'raffles'
  resources 'winners', only: ['index']
end
