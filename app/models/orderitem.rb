class Orderitem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {greater_than: 0}

  def subtotal
    return self.quantity * (Product.find_by(id: self.product_id).price / 100)
  end

  def self.find_order_items_by_product(product)
    where(product_id: product.id)
  end

  def self.display_shipment(order_item)
    if order_item.status?
      return "Yes"
    else
      return "Not yet"
    end
  end

  def self.count_unshipped_orders(order_item)
    unshipped_order = 0
    Order.find_by(id: order_item.order_id).orderitems.each do |order_item|
      if order_item.status == false
        unshipped_order += 1
      end
    end
    return unshipped_order
  end

  def self.update_order_status(order_item, unshipped_order_count)
    current_order = Order.find_by(id: order_item.order_id)
    if unshipped_order_count == 0
      current_order.update(status: "complete")
    elsif current_order.name
      Order.find_by(id: order_item.order_id).update(status: "paid")
    elsif !current_order.name
      Order.find_by(id: order_item.order_id).update(status: "pending")
    end
  end
end
