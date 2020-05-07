class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chat_id, :created_at, :user
  has_one :user

end
