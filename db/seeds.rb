
Company.destroy_all
Event.destroy_all
Attendee.destroy_all
Package.destroy_all

Event.create(title: 'Event #1', from: Time.now + 6.week, to: Time.now + 6.week + 2.days, location: "Leng, Ohiyo")
Event.create(title: 'Event #2', from: Time.now + 6.week, to: Time.now + 6.week + 2.days, location: "Campton, Ohiyo")

Package.create(name: 'EXPO STANDARD PACKAGE', price: 3000, description: '10’ x 10’ Booth, signage, 8’ table, and trash bin')
Package.create(name: 'ULTRA PACKAGE', price: 5000, description: '15’ x 15’ Booth, signage, 10’ table, and trash bin')
