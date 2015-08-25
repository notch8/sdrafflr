class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def voice
  	response = Twilio::TwiML::Response.new do |r|
  	  r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
  	end
  	render_twiml response
  end

 def message
    body = params[:Body]
    from = params[:From]

    #Just saving a record to the messages table, we don't do anything with this data
    @message = Message.new(:body => body, :from => from)
    @message.save

    raffle_id = body.gsub(/[^\d]/, '').to_i
    name = body.gsub(/\d+\s/, '')

    raffle_title = Raffle.find_by(id: raffle_id).title

    c = Contestant.find_or_create_by(name: name)
    p = Participation.new(:contestant_id => c.id, :raffle_id => raffle_id, :from => from)


    if p.save
      response = Twilio::TwiML::Response.new do |r|
        r.Message "You have successfully entered the raffle. Good luck!"
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Message "Something went wrong."
      end
    end

    render_twiml response

    head :success

 end


end
