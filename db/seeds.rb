# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
languages = ['German', 'French', 'Italian' , 'Vietnamese']
languages_second = ['Chinese', 'Russian', 'Dutch' , 'Greek']
# Faker::Name.name
User.destroy_all
Profile.destroy_all
30.times do
  user = User.create!(email: Faker::Internet.email, password: '123456')
  Profile.create!(user_id: user.id, address: "#{Faker::Address.city}, #{Faker::Address.country}", age: rand(18..99), native_language: languages.sample, second_language: languages_second.sample, bio: Faker::Marketing.buzzwords, name: Faker::Name.name)
end

