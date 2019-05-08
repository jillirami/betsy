class Orderitem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {greater_than: 0}

  def self.find_order_items_by_product(product)
    where(product_id: product.id)
  end
  
end
