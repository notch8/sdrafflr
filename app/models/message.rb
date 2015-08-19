class Message < ActiveRecord::Base
  after_create :add_to_raffle

  private

     def receive_message
       response = RestClient::Request.new(
         :method => :post,
         :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
         :user => ENV['TWILIO_ACCOUNT_SID'],
         :password => ENV['TWILIO_AUTH_TOKEN'],
         :payload => { :Body => body,
                       :To => to,
                       :From => from }
       ).execute
     end
end
