class UserContactsController < ApplicationController
  before_action :set_user_contact, only: [:show, :update, :destroy]

  # GET /user_contacts
  def index
    @user_contacts = UserContact.all

    render json: @user_contacts
  end

  # GET /user_contacts/1
  def show
    render json: @user_contact
  end

  # POST /user_contacts
  def create
    @user_contact = UserContact.new(user_contact_params)

    if @user_contact.save
      render json: @user_contact, status: :created, location: @user_contact
    else
      render json: @user_contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_contacts/1
  def update
    if @user_contact.update(user_contact_params)
      render json: @user_contact
    else
      render json: @user_contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_contacts/1
  def destroy
    @user_contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_contact
      @user_contact = UserContact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_contact_params
      params.require(:user_contact).permit(:user_id, :contact_id)
    end
end
