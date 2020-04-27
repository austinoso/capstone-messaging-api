class MessagesChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:chat_id])
    byebug
    stream_for chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
end
