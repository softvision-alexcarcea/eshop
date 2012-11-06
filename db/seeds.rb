# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# create products
100.times do
  Product.create! :name => Faker::Lorem.words,
                  :description => Faker::Lorem.sentences,
                  :price => rand(1..20) + 0.99

# create admin
Admin.create! :email => "admin@eshop.com",
              :password => "letmein",
              :password_confirmation => "letmein"
end
