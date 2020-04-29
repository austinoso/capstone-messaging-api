class PendingContactSerializer < ActiveModel::Serializer
  attributes :id
  has_one :receiver

end
