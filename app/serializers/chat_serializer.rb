class ChatSerializer < ActiveModel::Serializer
  attributes :id
  has_one :initiator, serializer: UserSerializer
  has_one :recipient, serializer: UserSerializer
  has_many :messages
end
