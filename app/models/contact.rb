class Contact < ApplicationRecord
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  scope :contacts, -> { where("status =?", true) }
  scope :not_contacts, -> { where("status =?", false) }

end
