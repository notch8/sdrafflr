Rails.application.routes.draw do
  root 'raffles#index'
  resources 'raffles'
  resources 'winners', only: ['index']
  post 'twilio/message' => 'twilio#message'
  get '/get_participants', to: "raffles#edit"
end
