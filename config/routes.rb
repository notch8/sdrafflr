Rails.application.routes.draw do
  root 'raffles#index'
  resources 'raffles'
  resources 'winners', only: ['index']
  post 'twilio/voice' => 'twilio#voice'
end
