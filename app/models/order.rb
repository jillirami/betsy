class Order < ApplicationRecord
  has_many :orderitems

  def cart
    cart = {}

    quantity = 0

    self.orderitems.each do |order_item|
      quantity += Orderitem.find_by(id: order_item.id).quantity

      cart[Orderitem.find_by(product_id: order_item.product_id)] = quantity
    end
    return cart
  end

  def cart_total
    cart_total = 0

    self.orderitems.each do |order_item|
      cart_total += order_item.subtotal
    end

    return cart_total
  end
end
