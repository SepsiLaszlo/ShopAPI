# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |number|
    p "User ##{number + 1} created"
    User.create!(email: Faker::Internet.email)
end

1000.times do |number|
    p "Product ##{number + 1} created"
    Product.create!(name: Faker::Appliance.equipment,
                    price: (10..100000).to_a.sample,
                    quantity: (5..100).to_a.sample)
end