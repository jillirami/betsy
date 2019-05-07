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
end
