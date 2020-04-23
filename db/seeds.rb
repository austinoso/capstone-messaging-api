# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Contact.destroy_all
User.destroy_all

5.times { User.create!(username: Faker::Name.first_name)  }

u1 = User.first
u2 = User.second
u3 = User.third
u4 = User.fourth
u5 = User.fifth

Contact.create(sender: u2, receiver: u4)
Contact.create(sender: u1, receiver: u4, status: true)
Contact.create(sender: u1, receiver: u2)
Contact.create(sender: u3, receiver: u1)
Contact.create(sender: u2, receiver: u5)
