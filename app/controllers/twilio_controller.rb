class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token


 def message
    body = params[:Body]
    from = params[:From]

    @message = Message.new(:body => body, :from => from)
    @message.save

    parts = body.split(/(\d+)/)
 end


end
