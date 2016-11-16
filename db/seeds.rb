# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    role: rand(0..2)
  )
end

users = User.all

30.times do
  Wiki.create!(
    title: Faker::Lorem.words.join(" "),
    body: Faker::Lorem.paragraph(3),
    user: users.sample
  )
end

wikis = Wiki.all

puts "Seeding complete."
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
