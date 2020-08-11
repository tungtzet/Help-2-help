# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

avatar_names = ["felipeandreslugosalazar",
  "petermagpantay",
  "vincm1",
  "tungtzet",
  "melanieschaufler",
  "leo-scheiter",
  "CarlaJule",
  "LSchemuth",
  "fetzi123",
  "nicolotor",
  "paul-wittchen",
  "LiLVinci"]

avatar = 'https://kitt.lewagon.com/placeholder/users/'
languages = ['German', 'French', 'Italian' , 'Vietnamese']
languages_second = ['Chinese', 'Russian', 'Dutch' , 'Greek']
User.destroy_all
Profile.destroy_all
Disease.destroy_all
5.times do
  avatar_selected = avatar_names.sample
  image = "#{avatar}#{avatar_selected}"
  user = User.create!(email: Faker::Internet.email, password: '123456')
  profile = Profile.create!(user_id: user.id, address: "#{Faker::Address.city}, #{Faker::Address.country}", age: rand(18..99), native_language: languages.sample, second_language: languages_second.sample, bio: Faker::Marketing.buzzwords, name: Faker::Name.name)
  file = URI.open(image)
  profile.photo.attach(io: file, filename: profile.name, content_type: 'image/jpg')
end

letters = ("a".."z").to_a
url = 'https://www.cdc.gov/DiseasesConditions/az/'

letters.each do |letter|
  full_url = url + letter + ".html"
  html_file = open(full_url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.unstyled-list > li').each do |element|
    disease_name = element.text.strip
    disease = Disease.create!(name: disease_name)
  end
end
