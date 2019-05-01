require "faker"
require "date"
require "csv"

# we already provide a filled out media_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new media_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

test_merchant = Merchant.create(username: "seller1", email: "email@email.com")

CSV.open("db/spices_seeds.csv", "w", :write_headers => true,
                                     :headers => ["name", "price", "description", "photo", "inventory", "merchant_id"]) do |csv|
  25.times do
    name = Faker::Food.spice
    price = Faker::Number.between(100, 100000)
    description = Faker::Lorem.sentence
    photo = "https://www.flickr.com/photos/67345249@N06/7519730426/in/photolist-csuzSA-UJQNe3-8o4tSN-32Fzza-qB8JZQ-qpwm9Z-qBfPrR-22TEdyt-Tx2D8K-Twnhx2-jHy3Ax-nVL4jX-5LiZeu-dEMrKG-8FpVZn-49f7Mi-7Cviom-2ckP8hh-jWaRL-5DKnq-dEMzvE-4J8ugU-5EQn-dbfsvz-ACeqh-qsFxU5-MBUg1-G895ky-4AWqMz-4m7o1q-UM3Rsx-5DA1QE-bxmYSY-2fx5cin-bxtBA3-4eps6x-dVtGXq-f8ptcA-9pGYXV-QisuaB-7HPiTH-ehBgDS-9qTUkT-4NptMG-pHenm-fJ2YYH-8GEcYH-6Rsv8H-2fx4hHH-opWRNd"
    inventory = Faker::Number.between(0, 20)
    merchant_id = test_merchant.id

    csv << [name, price, description, photo, inventory, merchant_id]
  end
end
