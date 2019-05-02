5.times do |index|
  Merchant.create!(username: Faker::Internet.username, email: Faker::Internet.free_email, name: Faker::Name.name, uid: Faker::Number.number(8), provider: "github")
end

merchants = Merchant.all


5.times do |index|
  Product.create!(name: Faker::Food.spice, price: Faker::Number.leading_zero_number(6), description: Faker::Lorem.sentence, photo: "https://www.flickr.com/photos/67345249@N06/7519730426/in/photolist-csuzSA-UJQNe3-8o4tSN-32Fzza-qB8JZQ-qpwm9Z-qBfPrR-22TEdyt-Tx2D8K-Twnhx2-jHy3Ax-nVL4jX-5LiZeu-dEMrKG-8FpVZn-49f7Mi-7Cviom-2ckP8hh-jWaRL-5DKnq-dEMzvE-4J8ugU-5EQn-dbfsvz-ACeqh-qsFxU5-MBUg1-G895ky-4AWqMz-4m7o1q-UM3Rsx-5DA1QE-bxmYSY-2fx5cin-bxtBA3-4eps6x-dVtGXq-f8ptcA-9pGYXV-QisuaB-7HPiTH-ehBgDS-9qTUkT-4NptMG-pHenm-fJ2YYH-8GEcYH-6Rsv8H-2fx4hHH-opWRNd", inventory: Faker::Number.between(1, 25), merchant_id: merchants.sample.id)
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
