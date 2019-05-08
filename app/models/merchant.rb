class Merchant < ApplicationRecord
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.build_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash[:uid]
    merchant.provider = "github"
    merchant.name = auth_hash["info"]["name"]
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]
    return merchant
  end

  def self.find_products(merchant)
    Product.where(merchant_id: merchant.id)
  end

  def self.find_order_items(merchant)
    orders = []

    products = find_products(merchant)
    products.each do |p|
      order_items = Orderitem.find_order_items_by_product(p)
      order_items.each do |order_items|
        orders << order_items
      end
    end
    return orders.sort!
  end

  def self.calculate_subtotal(order_item)
    subtotal_cents = 0
    subtotal_cents += order_item.quantity * order_item.product.price
    subtotal = subtotal_cents / 100.00
    return subtotal
  end
end
