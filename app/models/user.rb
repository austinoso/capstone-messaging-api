class User < ApplicationRecord
    has_many :user_contacts, dependdent: :destroy
    has_many :contacts, through: :user_contacts
end
