class User < ApplicationRecord
    has_many :contacts_req_sent, class_name: 'Contact', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy
    has_many :contacts_req_received, class_name: 'Contact', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy

    has_many :sent_contacts, -> {merge(Contact.contacts)}, through: :contacts_req_sent, source: :receiver
    has_many :received_contacts, -> {merge(Contact.contacts)}, through: :contacts_req_received, source: :sender
    has_many :pending_requests, -> {merge(Contact.not_contacts)}, through: :contacts_req_sent, source: :receiver
    has_many :received_requests, -> {merge(Contact.not_contacts)}, through: :contacts_req_received, source: :sender

    def contacts
        sent_contacts + received_contacts
    end
end
