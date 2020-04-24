class User < ApplicationRecord
    #### LOGIN ####
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    #### CONTACTS ####
    has_many :contact_reqs_sent, class_name: 'Contact', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy
    has_many :contact_reqs_received, class_name: 'Contact', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy

    has_many :sent_contacts, -> {merge(Contact.contacts)}, through: :contact_reqs_sent, source: :receiver
    has_many :received_contacts, -> {merge(Contact.contacts)}, through: :contact_reqs_received, source: :sender
    has_many :pending_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_sent, source: :receiver
    has_many :received_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_received, source: :sender

    def contacts
        sent_contacts + received_contacts
    end

    #### CHATS ####
    has_many :chats_created, class_name: 'Chat', foreign_key: 'initiator_id', inverse_of: 'initiator'
    has_many :chats_received, class_name: 'Chat', foreign_key: 'recipient_id', inverse_of: 'recipient'

    def chats
        chats_created + chats_received
    end
end
