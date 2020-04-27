class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chat_id
  has_one :user

end
