# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

UserDisease.destroy_all
# Friendship.destroy_all
# User.destroy_all
# Profile.destroy_all
Disease.destroy_all

# avatar_names = ["felipeandreslugosalazar",
#   "petermagpantay",
#   "vincm1",
#   "tungtzet",
#   "melanieschaufler",
#   "CarlaJule",
#   "LSchemuth",
#   "fetzi123",
#   "nicolotor",
#   "awwebdev2020",
#   "paul-wittchen",
#   "zcallanan"]

letters = ("a".."b").to_a
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

# avatar = 'https://kitt.lewagon.com/placeholder/users/'
# languages = ['German', 'French', 'Italian' , 'Vietnamese']
# languages_second = ['Chinese', 'Russian', 'Dutch' , 'Greek']
# 35.times do
#   avatar_selected = avatar_names.sample
#   image = "#{avatar}#{avatar_selected}"
#   user = User.create!(email: Faker::Internet.email, password: '123456')
#   profile = Profile.create!(user: user, address: "#{Faker::Address.city}, #{Faker::Address.country}", age: rand(18..99), native_language: languages.sample, second_language: languages_second.sample, bio: Faker::Marketing.buzzwords, name: Faker::Name.name)
#   UserDisease.create!(profile: profile, disease: Disease.all.sample)
#   file = URI.open(image)
#   puts image
#   profile.photo.attach(io: file, filename: profile.name, content_type: 'image/jpg')
# end


