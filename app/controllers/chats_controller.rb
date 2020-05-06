class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy, :messages]

  skip_before_action :authorized

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    if @chat #&& @chat.users.include?(current_user)
      render json: @chat.messages
    else
      render json: @chat.errors, status: :unauthorized
    end
  end

  def messages
    if @chat# && @chat.users.include?(current_user)
      render json: @chat, include: ['messages.*']
    else
      render json: @chat.error, status: :unauthorized
    end
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ChatSerializer.new(@chat)
      ).serializable_hash

      ChatsChannel.broadcast_to(@chat.initiator, serialized_data)
      ChatsChannel.broadcast_to(@chat.recipient, serialized_data)
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    if @chat.destroy
      ChatsChannel.broadcast_to(@chat.recipient, {chat: @chat, action: 'DEL'})
      ChatsChannel.broadcast_to(@chat.initiator, {chat: @chat, action: 'DEL'})
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.require(:chat).permit(:initiator_id, :recipient_id)
    end

end
