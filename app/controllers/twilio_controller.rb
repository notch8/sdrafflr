class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token


 def message
    body = params[:Body]
    from = params[:From]

    @message = Message.new(:body => body, :from => from)
    @message.save

    raffle_id = body.gsub(/[^\d]/, '').to_i
    name = body.gsub(/\d+\s/, '')

    c = Contestant.find_or_create_by(name: name)
    Participation.create(:contestant_id => c.id, :raffle_id => raffle_id)

    head :success

 end


end
