require 'test_helper'

class UserContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_contact = user_contacts(:one)
  end

  test "should get index" do
    get user_contacts_url, as: :json
    assert_response :success
  end

  test "should create user_contact" do
    assert_difference('UserContact.count') do
      post user_contacts_url, params: { user_contact: { contact_id: @user_contact.contact_id, user_id: @user_contact.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show user_contact" do
    get user_contact_url(@user_contact), as: :json
    assert_response :success
  end

  test "should update user_contact" do
    patch user_contact_url(@user_contact), params: { user_contact: { contact_id: @user_contact.contact_id, user_id: @user_contact.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy user_contact" do
    assert_difference('UserContact.count', -1) do
      delete user_contact_url(@user_contact), as: :json
    end

    assert_response 204
  end
end
