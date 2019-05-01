class Product < ApplicationRecord
  belongs_to :merchant 
  has_many :categories 
  has_many :reviews 
  has_many :orderitems

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end


