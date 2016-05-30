
# Company.destroy_all
# Event.destroy_all
# Question.destroy_all
# Answer.destroy_all
# Attendee.destroy_all
# Package.destroy_all
# Hotel.destroy_all
# Bus.destroy_all

e1 = Event.create(title: 'EXPO #1', from: Time.now + 6.week, to: Time.now + 6.week + 2.days, location: "Springfield, MA")
e2 = Event.create(title: 'EXPO #2', from: Time.now + 8.week, to: Time.now + 8.week + 2.days, location: "Springfield, MA")

Package.create(name: 'EXPO STANDARD PACKAGE', price: 3000, description: '10’ x 10’ Booth, signage, 8’ table, and trash bin')
Package.create(name: 'ULTRA PACKAGE',         price: 5000, description: '15’ x 15’ Booth, signage, 10’ table, and trash bin')

Hotel.create(name: 'Sheraton Hotels (Springfield MA)', price: 125)
Hotel.create(name: 'Mariott Hotels (Springfield MA)', price: 125)

b1 = Bus.create(seats_limit: 4)
b2 = Bus.create(seats_limit: 1)
b3 = Bus.create(seats_limit: 2)

b4 = Bus.create(seats_limit: 4)
b5 = Bus.create(seats_limit: 4)
b6 = Bus.create(seats_limit: 4)

e1.buses << b1 << b2 << b3
e2.buses << b4 << b5 << b6

AdminUser.create(email: "admin@griffinmail.com", password: "password", password_confirmation: 'password')
