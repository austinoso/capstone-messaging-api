class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email
  
  has_many :contacts, serializer: ContactSerializer
  has_many :pending_requests, serializer: ContactSerializer
  has_many :received_requests, serializer: ContactSerializer
  has_many :chats
end
