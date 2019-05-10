require "faker"

merchants_info = [
  { username: "miraculous", email: "miraculous@tipsy.com", name: "Miraculous MWD", uid: Faker::Number.number(8), provider: "github" },
  { username: "joyous", email: "joyous@tipsy.com", name: "Joyous JR", uid: Faker::Number.number(8), provider: "github" },
  { username: "hungry", email: "hungry@tipsy.com", name: "Hungry HI", uid: Faker::Number.number(8), provider: "github" },
  { username: "notorious", email: "notorious@tipsy.com", name: "Noble NL", uid: Faker::Number.number(8), provider: "github" },
]

merchants_info.each do |merchant|
  Merchant.create!(merchant)
end

merchants = Merchant.all

categories = [
  {name: "libations"},
  {name: "accoutrements"},
]

categories.each do |category|
  Category.create!(category)
end

products_non_beverages = [
  { name: "Rosemary Crackers", price: 700, description: "What isn't made better with some rosemary crackers?", photo: "http://i63.tinypic.com/r8838w.jpg", inventory: 20, merchant_id: merchants.sample.id },
  { name: "Moscow Mule Set", price: 1500, description: "So you can make them at home!", photo: "http://i63.tinypic.com/2954t1c.jpg", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Castelvetrano Olives", price: 1500, description: "Olives should come with every cocktail.", photo: "http://i68.tinypic.com/adc0ow.jpg", inventory: 7, merchant_id: merchants.sample.id },
  { name: "Black Olive Tapenade", price: 1200, description: "Those rosemary crackers would be even better with this tapenade!", photo: "http://i66.tinypic.com/xfdips.jpg", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Seattle Glass", price: 1200, description: "I heart Seattle!", photo: "http://i67.tinypic.com/9k5ymg.jpg", inventory: 20, merchant_id: merchants.sample.id },
  { name: "Cocktail Shaker", price: 1800, description: "Shaken, not stirred.", photo: "http://i68.tinypic.com/2nu0qz7.jpg", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Martini Glass", price: 1500, description: "Every cocktail feels fancier in a martini glass.", photo: "http://i68.tinypic.com/oribnq.jpg", inventory: 20, merchant_id: merchants.sample.id },
  { name: "Cheese Board", price: 2000, description: "Cheese, please!", photo: "http://i63.tinypic.com/25513k5.jpg", inventory: 4, merchant_id: merchants.sample.id },
  { name: "Copper Mug", price: 1500, description: "MOSCOW! MULES!", photo: "http://i68.tinypic.com/24l5ysz.jpg", inventory: 16, merchant_id: merchants.sample.id },
  { name: "Red Wine Decanter", price: 1500, description: "Let your wine breathe!", photo: "http://i63.tinypic.com/308yx4k.jpg", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Waffleshot", price: 1000, description: "Shots are never a good idea...but if you must.", photo: "http://i65.tinypic.com/2nio9ph.jpg", inventory: 15, merchant_id: merchants.sample.id },
  { name: "Tequila Mockingbird", price: 1500, description: "Cocktails with a literary twist.", photo: "http://i66.tinypic.com/2j2sqgy.jpg", inventory: 6, merchant_id: merchants.sample.id },
]

products_beverages = [
  { name: "Vodka, Copperworks Distilling", price: 3000, description: "(You should also buy some copper mugs and a Moscow Mule set.)", photo: "http://i67.tinypic.com/swwbjp.jpg", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Rye Whiskey, Mischief Distillery", price: 4000, description: "It's from a place called Mischief Distillery, you know you need to buy this.", photo: "http://i68.tinypic.com/s5wdts.jpg", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Joy Sake, Sake One", price: 3500, description: "Joy in a bottle.", photo: "http://i67.tinypic.com/2s0jodk.jpg", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Riesling", price: 2000, description: "Paired with some spicy Asian food...perfection!", photo: "http://i63.tinypic.com/iyzle8.jpg", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Tequila, Casamigos de Agave", price: 5000, description: "George Clooney's tequila, enough said.", photo: "http://i64.tinypic.com/33cy77l.jpg", inventory: 7, merchant_id: merchants.sample.id },
  { name: "Gin, Oola Distilling", price: 3000, description: "Oola la! G&T's tonight!", photo: "http://i64.tinypic.com/wu458w.jpg", inventory: 12, merchant_id: merchants.sample.id },
  { name: "Pear Brandy, Clear Creek Distilling", price: 5000, description: "Yep, that's a whole pear in the bottle!", photo: "http://i65.tinypic.com/2jagaph.jpg", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Coffee Liqueur, Seattle Distilling", price: 2800, description: "Coffee + booze = yum", photo: "http://i66.tinypic.com/53s27n.jpg", inventory: 8, merchant_id: merchants.sample.id },
  { name: "Cannabis Absinthe", price: 5400, description: "If you thought boozy coffee was a good idea, wait until you try this!", photo: "http://i68.tinypic.com/20uze6b.jpg", inventory: 8, merchant_id: merchants.sample.id },
]

products_non_beverages.each do |product_hash|
  new_product = Product.create!(product_hash)
  new_product.categories << Category.find_by(name: "accoutrements")
end

products_beverages.each do |product_hash|
  new_product = Product.create!(product_hash)
  new_product.categories << Category.find_by(name: "libations")
end

reviews = [
  {reviewer: Faker::Name.name, rating: 5, description: "If you can't afford ticket to party in Russia, this Vodka would have given you the same experience!!! 5 stars!", product_id: Product.find_by(name: "Vodka, Copperworks Distilling").id},
  {reviewer: Faker::Name.name, rating: 2, description: "I am not getting the previous hype, Costco Vodka tastes better than this", product_id: Product.find_by(name: "Vodka, Copperworks Distilling").id},
  {reviewer: Faker::Name.name, rating: 5, description: "Highly recommend with sushi! One of the best Sakes I have ever had", product_id: Product.find_by(name: "Joy Sake, Sake One").id},
  {reviewer: Faker::Name.name, rating: 5, description: "OMG, Canabis Absinthe gets you high and drunk at the same time. It goes really well with cheese (just like a fine bottle of wine) you will be surprised!!!!", product_id: Product.find_by(name: "Canabis Absinthe").id},
  {reviewer: Faker::Name.name, rating: 5, description: "Whoever invented this drink is a genius. It hits me so hard that I became a dance machine despite being an introvert :)", product_id: Product.find_by(name: "Canabis Absinthe").id},
  {reviewer: Faker::Name.name, rating: 2, description: "Tastes ok! but the price does not justify the quality", product_id: Product.find_by(name: "Rosemary Crackers").id},
  {reviewer: "Unlucky Luke", rating: 1, description: "This arrived broken!", product_id: Product.find_by(name: "Seattle Glass").id},
  {reviewer: "Unlucky Luke", rating: 5, description: "This is an updated review, seller reached out and shipped me new Glass. Great Customer Service!!! I will come back to buy more stuffs", product_id: Product.find_by(name: "Seattle Glass").id},
]

reviews.each do |review|
  Review.create!(review)
end
