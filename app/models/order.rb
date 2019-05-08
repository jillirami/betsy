class Order < ApplicationRecord
  has_many :orderitems

  validates :name, presence: true

  def cart
    cart = {}

    total_quantity = 0

    self.orderitems.each do |order_item|
      total_quantity += order_item.quantity

      cart[Product.find_by(id: order_item.product_id).name] = total_quantity
    end
    return cart
  end
end
