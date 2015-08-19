Rails.application.routes.draw do
  root 'raffles#index'
  resources 'raffles'
  get '/previous_winners', to: 'raffles#old'
end
