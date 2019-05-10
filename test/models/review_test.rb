require "test_helper"

describe Review do
  let (:product) { products(:two) }
  let (:review) { reviews(:review) }

  it "must be valid" do
    valid_review = review.valid?

    expect(valid_review).must_equal true
  end

  describe "validations" do
    it "requires a rating" do
      review = Review.new(reviewer: "Leo")
      review.valid?.must_equal false
      review.errors.messages.must_include :rating
    end

    it "requires price input to be integer" do
      name = "test name"
      rating = "one"
      review = Review.new(rating: rating)

      review.valid?.must_equal false
      review.errors.messages.must_include :rating
    end
  end

  describe "relationships" do
    it "belongs to a product" do
      #product fixture :two has been assigned a review in the review fixture file
      expect(product.reviews[0].rating).must_equal review.rating
    end

    it "can set the product through the product_id" do
      review.product_id = product.id

      expect(product.reviews).must_include review
    end

    it "can have 0 review" do
      another_product = products(:one)

      expect(another_product.reviews.length).must_equal 0
    end

    it "can have 1 or more review by shoveling a review into product.reviews" do
      product.reviews << review

      expect(product.reviews).must_include review
    end
  end
  describe "average rating - custom method" do
    it "returns 0 if the product has no rating" do
      product_with_no_rating = products(:one)

      average_rating = Review.average_rating(product_with_no_rating)

      expect(average_rating).must_equal 0
    end

    it "returns the accurate average if the product has more than 1 rating" do
      # product has two ratings of 5 and 1 (see review fixture). The average rating expected is 3 [(5+1)/2]
      average_rating = Review.average_rating(product)

      expect(average_rating).must_equal 3
    end
  end
end
