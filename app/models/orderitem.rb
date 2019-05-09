class Orderitem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def subtotal
    return self.quantity * (Product.find_by(id: self.product_id).price / 100)
  end

  def self.find_order_items_by_product(product)
    where(product_id: product.id)
  end
  
end
