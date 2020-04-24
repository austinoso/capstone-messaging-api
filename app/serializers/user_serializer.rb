class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email
  has_many :chats
  has_many :pending_requests
  has_many :contact_reqs_received
end
