5.times do |index|
  Merchant.create!(username: Faker::Internet.username, email: Faker::Internet.free_email, name: Faker::Name.name, uid: Faker::Number.number(8), provider: "github")
end

merchants = Merchant.all


5.times do |index|
  Product.create!(name: Faker::Food.spice, price: Faker::Number.leading_zero_number(6), description: Faker::Lorem.sentence, photo: "https://picsum.photos/200/300", inventory: Faker::Number.between(1, 25), merchant_id: merchants.sample.id)
end

categories = [
  {name: "jewelry"},
  {name: "spice"},
  {name: "oneofakind"}
]

category_classes = []

categories.each do |category|
  category_classes << Category.create!(category)
end

Product.all.each do |product|
  product.categories << category_classes.sample(rand(3))
end

# 10.times do |index|
#   Review.create!(rating: Faker::Number.between(1, 5), description: Faker::Lorem.sentence, product_id: Faker::Number.between(1, 5))
# end
