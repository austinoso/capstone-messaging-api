class Chat < ApplicationRecord
  belongs_to :initiator, class_name: "User", foreign_key: "initiator_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  has_many :messages
end
