class ContactSerializer < ActiveModel::Serializer
  attributes :id
  has_one :receiver
  has_one :sender
end
