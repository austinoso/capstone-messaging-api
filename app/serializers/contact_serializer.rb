class ContactSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :receiver
  has_one :sender
end
