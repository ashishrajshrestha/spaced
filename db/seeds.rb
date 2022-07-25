# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Destroying all bookings"
Booking.destroy_all
puts "Destroying all spaces"
Space.destroy_all
puts "Destroying all users"
User.destroy_all

puts "creating 5 users"

# User.create!(
#   email: "dev@email.com",
#   password: "123123"
# )

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "123456"
  )
end

puts "5 users created"
puts "making 20 spaces"

20.times do
  user_ids = User.all.pluck(:id)
  s = Space.create!(
    title: Faker::Space.star_cluster,
    location: Faker::Address.city,
    image: Faker::LoremPixel.image(size: "50x60", is_gray: false, category: 'business'),
    capacity: rand(2..50),
    fee: rand(1..100) * 1000,
    size: Faker::Number.number(digits: 2),
    user_id: user_ids.sample,
  )
  b = Booking.create!(
    space_id: s.id,
    user_id: user_ids.reject { |id| id == s.user_id}.sample,
    from: Time.now.getutc,
    to: Time.now.getutc + 1000000
  )
end
puts "20 spaces created"
