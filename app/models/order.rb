class Order < ApplicationRecord
  has_many :orderitems

  def cart
    itemized_cart = {}
    quantity = 0

    self.orderitems.each do |order_item|
      itemized_cart[order_item] = quantity + order_item.quantity
    end

    final_cart = Hash.new(0)

    itemized_cart.each do |order_item, quantity|
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

  def shipped_items
    if self.status == "paid"
      shipped_items = 0
      self.orderitems.each do |order_item|
        if order_item.status == true
          shipped_items += 1
        end
      end
      return shipped_items
    end
  end
end
