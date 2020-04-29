class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  skip_before_action :authorized

  #GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat, include: ['messages.*']
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
    #   serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #     ChatSerializer.new(@chat)
    #   ).serializable_hash
    #   ActionCable.server.brodcast 'chats_channel', serialized_data
    #   head :ok
    # end

      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
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
    @chat.destroy
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