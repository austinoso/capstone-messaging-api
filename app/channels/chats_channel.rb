class ChatsChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:id])
    p "Subed"
    stream_for chat
    # stream_from "chat_#{params[:id]}"
  end

  # def receive(data)
  #   message = message.new(message_params)

  #   if message.save
  #     ActionCable.server.brodcast("chat_#{params[:id]}", data)
  #   else
  #     console.log("message hand a error")
  #   end
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def message_params
    params.require(:message).permit(:user_id, :chat_id, :content)
  end
end
