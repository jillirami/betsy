require "test_helper"

describe Review do
  let (:product) { products(:one) }
  let (:review) { reviews(:sus_review) }

  it "must be valid" do
  p review
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
      product.reviews[0] = review

      expect(product.reviews[0].rating).must_equal review.rating
    end

    it "can set the product through the product_id" do
      review.product_id = product.id

      expect(product.reviews).must_include review
    end

    it "can have 0 category" do
      reviews = product.reviews

      expect(reviews.length).must_equal 0
    end

    it "can have 1 or more review by shoveling a review into product.reviews" do
      product.reviews << review

      expect(product.reviews).must_include review
    end
  end

end
