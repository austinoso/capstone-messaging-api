class User < ApplicationRecord
    #### LOGIN ####
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    #### CONTACTS ####
    has_many :contact_reqs_sent, class_name: 'Contact', foreign_key: 'sender_id', inverse_of: 'sender', dependent: :destroy
    has_many :contact_reqs_received, class_name: 'Contact', foreign_key: 'receiver_id', inverse_of: 'receiver', dependent: :destroy

    def pending_requests
        self.contact_reqs_sent.where(status: false)
    end    

    def received_requests
        self.contact_reqs_received.where(status: false)
    end

    #has_many :sent_contacts, -> {merge(Contact.contacts)}, through: :contact_reqs_sent, source: :receiver
    #ahas_many :received_contacts, -> {merge(Contact.contacts)}, through: :contact_reqs_received, source: :sender
    # has_many :pending_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_sent, source: :receiver
    # has_many :received_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_received, source: :sender

    # has_many :pending_requests, -> { where status: true}, through: :contact_reqs_sent, source: :sender
    # has_many :received_requests, -> {merge(Contact.not_contacts)}, through: :contact_reqs_received, source: :sender


    def contacts
        (self.contact_reqs_sent.where(status: true) + self.contact_reqs_received.where(status: true))
    end

    #### CHATS ####
    has_many :chats_created, class_name: 'Chat', foreign_key: 'initiator_id', inverse_of: 'initiator'
    has_many :chats_received, class_name: 'Chat', foreign_key: 'recipient_id', inverse_of: 'recipient'

    def chats
        chats_created + chats_received
    end
end
