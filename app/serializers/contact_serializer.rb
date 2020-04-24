class ContactSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :sender, serializer: UserSerializer

end
