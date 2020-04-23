class UserContactSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :contact
end
