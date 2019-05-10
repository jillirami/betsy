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

  def items_pending
    if self.status == "paid"
      shipped_orders = 0
      self.orderitems.each do |order_item|
        if order_item.status == true
          shipped_orders += 1
        end
      end
      return "#{shipped_orders}/#{self.orderitems.length} items have shipped!"
    end
  end
end
