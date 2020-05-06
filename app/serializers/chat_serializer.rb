class ChatSerializer < ActiveModel::Serializer
  attributes :id, :accepted, :last_message
  has_one :initiator, serializer: UserSerializer
  has_one :recipient, serializer: UserSerializer
  has_many :messages


 
end
