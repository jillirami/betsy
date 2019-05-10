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

  def self.find_order_items(merchant, status)
    orders = []
    if merchant.class == Merchant
      products = merchant.products
      products.each do |product|
        order_items = Orderitem.find_order_items_by_product(product)
        order_items.each do |order_item|
          if status == "all"
            orders << order_item
          elsif order = find_order_by_status(order_item, status)
            orders << order_item
          end
        end
      end
    end
    return orders.sort!
  end

  def self.find_order_by_status(order_item, status)
    order = Order.find_by(id: order_item.order_id)
    if order.status == status
      return order
    else
      return false
    end
  end

  def self.calculate_subtotal(order_item)
    if order_item.class == Orderitem
      subtotal_cents = 0
      subtotal_cents += order_item.quantity * order_item.product.price
      subtotal = subtotal_cents / 100.00
      return subtotal
    end
    return false
  end

  def self.show_all_products(merchant)
    return products = merchant.products
  end
end
