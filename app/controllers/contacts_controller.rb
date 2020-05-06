class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  # def index
  #   @contacts = Contact.all

  #   render json: @contacts
  # end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(receiver: User.find_by(username: contact_params[:receiver_username]), sender_id: contact_params[:sender_id] )

    if @contact.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ContactSerializer.new(@contact)
      ).serializable_hash

      ContactsChannel.broadcast_to(@contact.receiver, serialized_data)
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ContactSerializer.new(@contact)
      ).serializable_hash

      render json: @contact
      ContactsChannel.broadcast_to(@contact.sender, serialized_data)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:receiver_username, :sender_id, :status)
    end
end
