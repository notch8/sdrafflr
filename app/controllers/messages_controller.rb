class MessagesController < ApplicationController
  def create
    @message_body = params["Body"]
    @from_number = params["From"]
  end
end
