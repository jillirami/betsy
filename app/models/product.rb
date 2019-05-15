class Product < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :orderitems
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than: 0}

  def self.browse_by_category(category)
    joins(:categories).where(categories: {id: category.id}).distinct
  end

  def available_inventory?(quantity)
    return self.inventory >= quantity
  end

  def reduce_inventory_by!(quantity)
    new_inventory = (self.inventory - quantity)
      
    self.update(inventory: new_inventory)
  end

  def adjust_inventory_by!(prev_quantity, requested_quantity)
    available_quantity = self.inventory + prev_quantity

    if requested_quantity > available_quantity
      return prev_quantity
    else
      self.update(inventory: available_quantity - requested_quantity)
      return requested_quantity
    end
  end
end
