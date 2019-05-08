class Order < ApplicationRecord
  has_many :orderitems

  def cart
    cart = {}

    self.orderitems.each do |order_item|
      cart[order_item] = 0 + order_item.quantity
    end
    return cart
  end
end
