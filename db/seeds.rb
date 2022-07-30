# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

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

placeImage = [
  "https://i.pinimg.com/564x/5f/b0/f4/5fb0f441b2d8220318fb62dbc0ae48a0.jpg",
  "https://i.pinimg.com/564x/b8/fd/93/b8fd934aa26e5d90a8a07b86a485c073.jpg",
  "https://i.pinimg.com/originals/a3/63/ce/a363ce996e0cedd9ae100c236bbf92d9.jpg",
  "http://madonart.com/wp-content/uploads/2015/01/P1000366.jpg",
  "https://i.pinimg.com/originals/ff/e1/c2/ffe1c2e86b683b0e57b3599c1a103173.gif",
  "https://i.pinimg.com/564x/b5/5a/b6/b55ab6ea74a8b5989c13f5724a799f5e.jpg",
  "https://i.pinimg.com/564x/00/bd/45/00bd455c1786c0f487f0bc134ed97f7a.jpg",
  "https://i.pinimg.com/750x/82/47/6a/82476a0f3a716057ca1701df1e003c6c.jpg",
  "https://i.pinimg.com/564x/90/63/85/90638575b0a94a5967827c69580cfb26.jpg",
  "https://i.pinimg.com/564x/a5/84/ac/a584acae05302eadbd575359139e3ac3.jpg",
  "https://i.pinimg.com/564x/90/36/a6/9036a65606afd19761abb315fe33b6fc.jpg"
]

spaceDescription = [
  "Hold your next meeting, event, or film shoot at our space! Our unique event space is equipped with a kitchenette, catering table, projection, audio, and wireless Google Fiber internet. A perfect space for events or large meetings.
  Our space pet-friendly. Includes coffee, filtered water, and kitchenette access. Free on-site parking!
  Audio, video, and lighting system assistance is available.",
  "This space is excellent for anyone that needs a legit and beautiful looking recording studio for film or photo work. It is a fully functional and operating studio hidden away in the hip and central North Park area of San Diego. The studio is in walking distance from many of North Park's wonderful restaurants, bars, breweries, and shops. One or two cars can park in the driveway and the rest should easily find parking on the street nearby.",
  "Do you need professional space to host your online webinar or work meeting? Our room offers ample and professional-looking space as well as natural lighting. We supple a mounted TV with HDMI cord. Feel free to bring any additional lighting or mic equipment. Our space is quiet and part of a professional office suite. Conveniently located to I-85, I-285, and Midtown, this spacious event room is connected to a holistic healing practice including mental health therapists. The room is ideal for a professional workshop or lecture, business meeting, networking event, group therapy, or yoga/meditation class. ",
  "Large conference room & meeting space for 8-10 guests. Includes whiteboard wall, TV with HDMI/ Apple TV capability and speakerphone. Next to common space (shared space, not private), pantry and has access to roof deck. Great for board meetings, lunches, presentations, brainstorming sessions, and more! Lots of natural light through the skylight, as well.",
  "This elegant lounge is located inside a residential apartment home community in Mission Bay and China Basin. Situated off of Mission Creek park, this is an urban oasis perfect for a 15-20 person off-site event.  At approximately 1000 square feet the lounge features an indoor fireplace, large farm style table with 10 chairs, a seating area with two sofas and two occasional chairs, as well as four club chairs cozily located next to the fireplace "
]

spaceLocation = [
  "Meguro, Tokyo",
  "Shinagawa, Tokyo",
  "Setagaya, Tokyo",
  "Minato, Tokyo",
  "Shinjuku, Tokyo"
]


# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "5 users created"
puts "making 20 spaces"



20.times do
  user_ids = User.all.pluck(:id)
  gen_space_size = rand(3..50)
  file = URI.open(placeImage.sample)
  s = Space.create!(
    title: Faker::Space.star_cluster,
    location: spaceLocation.sample,
    address: spaceLocation.sample,
    image: placeImage.sample,
    capacity: gen_space_size,
    fee: rand(1..100) * 1000,
    size: gen_space_size * rand(1.1..3),
    user_id: user_ids.sample,
    description: spaceDescription.sample,
  )
  s.photos.attach(io: file, filename: 'space.jpg', content_type: 'image/*')
  b = Booking.create!(
    space_id: s.id,
    user_id: user_ids.reject { |id| id == s.user_id}.sample,
    from: Time.now.getutc  + 1000000,
    to: Time.now.getutc + 2000000
  )
end
puts "20 spaces created"
