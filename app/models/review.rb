class Review < ApplicationRecord
  belongs_to :product

  validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: 1..5}

  def self.average_rating(product)
    if product.reviews.length == 0
      return average_rating = 0
    else
      rating_sum = 0
      rating_count = product.reviews.length
      reviews_array = product.reviews

      reviews_array.each do |review|
        rating_sum += review.rating
      end

      average_rating = rating_sum / rating_count
    end
    return average_rating.to_f
  end
end
