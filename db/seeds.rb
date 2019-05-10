require "faker"

merchants_info = [
  { username: "miraculous", email: "miraculous@tipsy.com", name: "Miraculous MWD", uid: Faker::Number.number(8), provider: "github" },
  { username: "joyous", email: "joyous@tipsy.com", name: "Joyous JR", uid: Faker::Number.number(8), provider: "github" },
  { username: "hungry", email: "hungry@tipsy.com", name: "Hungry HI", uid: Faker::Number.number(8), provider: "github" },
  { username: "noble", email: "noble@tipsy.com", name: "Noble NL", uid: Faker::Number.number(8), provider: "github" },
]

merchants_info.each do |merchant|
  Merchant.create!(merchant)
end

merchants = Merchant.all

categories = [
  { name: "libations" },
  { name: "accoutrements" },
]

categories.each do |category|
  Category.create!(category)
end

products_non_beverages = [
  { name: "Rosemary Crackers", price: 700, description: "What isn't made better with some rosemary crackers?", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipMRo-G0U7AU0nY1y3MxI2O19_0X51GeU6B8pjQ?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 20, merchant_id: merchants.sample.id },
  { name: "Moscow Mule Set", price: 1500, description: "So you can make them at home!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipNM1LvchlPPrIaWd5raEZoGyMwSdpwVvm7OEwc?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Castelvetrano Olives", price: 1500, description: "Olives should come with every cocktail.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipPjE9XwBPF-vqOYVUXejLMYPcr79gB-tR4Hxq0?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 7, merchant_id: merchants.sample.id },
  { name: "Black Olive Tapenade", price: 1200, description: "Those rosemary crackers would be even better with this tapenade!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipNVLmCsI57ANY3vH7cdZEIzl-ssSk_Fd5nU4gM?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Seattle Glass", price: 1200, description: "I heart Seattle!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipM5YHyY75Dr56b0eZNa6wMy1UAD2hSnJ5jh5w8?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 20, merchant_id: merchants.sample.id },
  { name: "Cocktail Shaker", price: 1800, description: "Shaken, not stirred.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipNmggs37Jcqq9ls53Ykx7kkhH66RJjbzFTB2mU?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Martini Glass", price: 1500, description: "Every cocktail feels fancier in a martini glass.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipM4PGARUkin8icbWCRqDPBPV3WfDmgC8jpsZgY?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 20, merchant_id: merchants.sample.id },
  { name: "Cheese Board", price: 2000, description: "Cheese, please!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipM4qpqFJ6Pf9ClJmKZxEL-TqkBZnJ49claWCIo?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 4, merchant_id: merchants.sample.id },
  { name: "Copper Mug", price: 1500, description: "MOSCOW! MULES!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipP-08Ue0Vi6QQRvfsY5mttO8iGY_Koa6guVTsw?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 16, merchant_id: merchants.sample.id },
  { name: "Red Wine Decanter", price: 1500, description: "Let your wine breathe!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipPsadnaxvgW20f4foIUbyJBp7Hhc0lw_N5Y6UY?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Waffleshot", price: 1000, description: "Shots are never a good idea...but if you must.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipPcJ8FnONs73OIXSg2cQHJWGuilhefwgoRSnmE?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 15, merchant_id: merchants.sample.id },
  { name: "Tequila Mockingbird", price: 1500, description: "Cocktails with a literary twist.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipMJqTENi3GT3h1ygzDuEwKIcksce82swgc2sfw?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 6, merchant_id: merchants.sample.id },
]

products_beverages = [
  { name: "Vodka, Copperworks Distilling", price: 3000, description: "(You should also buy some copper mugs and a Moscow Mule set.)", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipPIJJJvHrX0tzQ1nq0YXc6oBobO6gCs92t4d4g?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Rye Whiskey, Mischief Distillery", price: 4000, description: "It's from a place called Mischief Distillery, you know you need to buy this.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipMuERfaZfGUBNx2gbju22i5X_6dWUeXqwUJKoM?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Joy Sake, Sake One", price: 3500, description: "Joy in a bottle.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipM5xX-ZmtPudqa1ZGhBS4vS7HU8JLY-xFOoKgQ?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Riesling", price: 2000, description: "Paired with some spicy Asian food...perfection!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipM4PGARUkin8icbWCRqDPBPV3WfDmgC8jpsZgY?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 10, merchant_id: merchants.sample.id },
  { name: "Tequila, Casamigos de Agave", price: 5000, description: "George Clooney's tequila, enough said.", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipMd1d6ocvZdmAdy7CBY5klHONbPKKB3KIAfW_s?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 7, merchant_id: merchants.sample.id },
  { name: "Gin, Oola Distilling", price: 3000, description: "Oola la! G&T's tonight!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipPeCEcjUupAT2wZa4K-p-84u5N3MdE_x4Z3kFk?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 12, merchant_id: merchants.sample.id },
  { name: "Pear Brandy, Clear Creek Distilling", price: 5000, description: "Yep, that's a whole pear in the bottle!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipP8i0vTRKbCnUrmGzTEDdJewLZoTjojUQXZC6Q?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 5, merchant_id: merchants.sample.id },
  { name: "Coffee Liqueur, Seattle Distilling", price: 2800, description: "Coffee + booze = yum", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipO3pbRVI1ezlb4jpLMYc2YpDR8fRB4e4NrnPzA?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 8, merchant_id: merchants.sample.id },
  { name: "Canabis Absinthe", price: 5400, description: "If you thought boozy coffee was a good idea, wait until you try this!", photo: "https://photos.google.com/share/AF1QipMPN66TcvjHmf3sceIu0iHAfTpxZ9ydKQGxh7L3bxJtjXwJp4W0p-SpZScnOgsdBg/photo/AF1QipOCDcbGJv22J2-Smk47DU3w5C9SRcg5ivNaIGo?key=WUR6TWFVMXNLR0p1Qm55YnU2SVBUX2VOcFE5azZ3", inventory: 8, merchant_id: merchants.sample.id },
]

products_non_beverages.each do |product_hash|
  new_product = Product.create!(product_hash)
  new_product.categories << Category.find_by(name: "accoutrements")
end

products_beverages.each do |product_hash|
  new_product = Product.create!(product_hash)
  new_product.categories << Category.find_by(name: "libations")
end

# 10.times do |index|
#   Review.create!(rating: Faker::Number.between(1, 5), description: Faker::Lorem.sentence, product_id: Faker::Number.between(1, 5))
# end
