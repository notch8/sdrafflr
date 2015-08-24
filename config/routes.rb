Rails.application.routes.draw do
  root 'raffles#index'
  resources 'raffles'
  resources 'winners', only: ['index']
  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/message' => 'twilio#message'
  get '/previous_winners', to: 'raffles#old'
end
