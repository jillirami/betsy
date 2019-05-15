class Orderitem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {greater_than: 0}

  def subtotal
    return self.quantity * (Product.find_by(id: self.product_id).price / 100)
  end
  
  def adjust_quantity_by!(requested_quantity)
    adjusted_quantity = self.product.adjust_inventory_by!(self.quantity, requested_quantity)

    if self.quantity != adjusted_quantity
      self.update(quantity: adjusted_quantity)
    end

    return adjusted_quantity
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
end
