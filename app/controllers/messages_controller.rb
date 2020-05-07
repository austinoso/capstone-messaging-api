class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  # def index
  #   @messages = Message.all

  #   render json: @messages
  # end

  # GET /messages/1
  def show
    render json: @message
  end


  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(@message)
      ).serializable_hash
      chat = Chat.find(@message.chat_id)
      MessagesChannel.broadcast_to(chat, {content: @message.content, user: { username: @message.user.username }, chat_id: @message.chat_id, created_at: @message.created_at})
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:user_id, :chat_id, :content)
    end
end
