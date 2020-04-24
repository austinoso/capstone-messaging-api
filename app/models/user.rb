class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    has_many :contact_reqs_sent, class_name: 'Contact', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy
    has_many :contact_reqs_received, class_name: 'Contact', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy

    has_many :sent_contacts, -> {merge(Contact.contacts)}, through: :contact_reqs_sent, source: :receiver
    has_many :received_contacts, -> {merge(Contact.contacts)}, through: :contact_reqs_received, source: :sender
    has_many :pending_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_sent, source: :receiver
    has_many :received_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_received, source: :sender

    def contacts
        sent_contacts + received_contacts
    end
end
