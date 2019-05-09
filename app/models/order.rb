class Order < ApplicationRecord
  has_many :orderitems

  def cart
    cart = {}

    quantity = 0

    self.orderitems.each do |order_item|
      cart[order_item] = quantity + order_item.quantity
    end

    final_cart = Hash.new(0)
    cart.each do | order_item, quantity|
      final_cart[Orderitem.find_by(product_id: order_item.product_id)] += quantity
    end

    return final_cart
  end

  def cart_total
    cart_total = 0

    self.orderitems.each do |order_item|
      cart_total += order_item.subtotal
    end

    return cart_total
  end
end
