class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

 def message
    body = params[:Body]
    from = params[:From]

    #Just saving a record to the messages table, we don't do anything with this data
    @message = Message.new(:body => body, :from => from)
    @message.save

    raffle_id = body.gsub(/[^\d]/, '').to_i
    name = body.gsub(/\d+\s/, '')

    raffle_title = Raffle.find_by(id: raffle_id).title

    c = Contestant.find_or_create_by(name: name.strip)
    p = Participation.new(:contestant_id => c.id, :raffle_id => raffle_id, :from => from)

    if p.save
      response = Twilio::TwiML::Response.new do |r|
        r.Message "You have successfully entered the raffle. Good luck!"
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Message "Sorry, only one entry per phone number."
      end
    end

    render_twiml response
 end


end
