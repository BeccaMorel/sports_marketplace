require "open-uri"
require 'faker'

User.destroy_all
Equipment.destroy_all
Booking.destroy_all
Review.destroy_all

puts 'Creating 6 users...'

alex = User.new({ first_name: "Alexander", last_name: "Encinas", email: "alexander.encinas@email.com", password: "111111", address: "3570 Boulevard Notre Dame, Laval, Quebec" })
alex.save!

emily = User.new({ first_name: "Emily", last_name: "Rockarts", email: "emily.rockarts@email.com", password: "111111", address: "5231 Avenue Du Parc, Montreal, Quebec" })
emily.save!

cloe = User.new({ first_name: "Cloe", last_name: "Furlan", email: "cloe.furlan@email.com", password: "111111", address: "5049 Rue De Lanaudiere, Montreal, Quebec" })
cloe.save!

rebecca = User.new({ first_name: "Rebecca", last_name: "Morel", email: "rebecca.morel@email.com", password: "111111", address: "3886 Place du Maréchal, Laval, Quebec" })
rebecca.save!

miguel = User.new({ first_name: "Miguel", last_name: "Hernandez", email: "miguel.hernandez@email.com", password: "111111", address: "5333, Avenue Casgrain, Montreal, Quebec" })
miguel.save!

nathan = User.new({ first_name: "Nathan", last_name: "Drake", email: "nathan.drake@email.com", password: "111111", address: "5757 Boulevard Thimens, Montreal, Quebec" })
nathan.save!

users = [alex, emily, cloe, miguel, nathan]

puts 'Creating 6 equipments...'
6.times do
  equipment = Equipment.new(
    name: Faker::Creature::Animal.name,
    description: Faker::Lorem.sentence,
    price: rand(10..50),
    user_id: users.sample.id
    )
  skateboard_one = URI.open('https://images.unsplash.com/photo-1589542425426-2460d8243b58?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')
  skateboard_two = URI.open('https://images.unsplash.com/photo-1554635917-1fb8f0f63f7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60')
  tent_one = URI.open('https://images.unsplash.com/photo-1519395612667-3b754d7b9086?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')
  tent_two = URI.open('https://images.unsplash.com/photo-1516361728389-998730856765?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')
  canoe_one = URI.open('https://images.unsplash.com/photo-1588178312022-be5b2a3d6e7a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')
  canoe_two = URI.open('https://images.unsplash.com/photo-1566554497832-cd49191043f0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')
  snowboard_one = URI.open('https://images.unsplash.com/photo-1498146831523-fbe41acdc5ad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')
  snowboard_two = URI.open('https://images.unsplash.com/photo-1546347255-ad7c1a2a5720?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60')

  pics = [skateboard_one, skateboard_two, tent_one, tent_two, canoe_one, canoe_two, snowboard_one, snowboard_two]

  equipment.photos.attach(io: pics.sample, filename: 'nes.png', content_type: 'image/png')
  equipment.save!
end

puts 'Finished!'