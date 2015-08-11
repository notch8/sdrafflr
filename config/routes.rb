Rails.application.routes.draw do
  root 'raffles#index'
  resources 'raffles'
end
