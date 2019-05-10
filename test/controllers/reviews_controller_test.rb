require "test_helper"

describe ReviewsController do
  let(:product) { products(:one) }

  describe "new" do
    it "succeeds" do
      get new_product_review_path(product.id)

      must_respond_with :success
    end

    it "display flash message when merchant attemp to review their own product" do
      perform_login(merchants(:jewelry))

      get new_product_review_path(product.id)

      expect(flash[:error]).must_equal "You can't review your own product"
    end
  end

  describe "create" do
    it "creates a review with valid data" do
      new_review_input = {
        "review": {
          reviewer: "Nosy",
          rating: 4,
          description: "dirty but good",
          product_id: product.id,
        },
      }

      expect {
        post product_reviews_path(product.id), params: new_review_input
      }.must_change "Review.count", 1

      must_respond_with :redirect
      must_redirect_to product_path(product.id)

      new_review = Review.find_by(reviewer: "Nosy")

      expect(flash[:success]).must_equal "Review successfully posted"
      expect(new_review).wont_be_nil
      expect(new_review.reviewer).must_equal new_review_input[:review][:reviewer]
      expect(new_review.rating).must_equal new_review_input[:review][:rating]
      expect(new_review.description).must_equal new_review_input[:review][:description]
      expect(new_review.product_id).must_equal new_review_input[:review][:product_id]
    end

    it "renders bad_request and does not update the DB for bogus data" do
      #create a bad review with an rating greater than 5
      bad_review = {
        "review": {
          reviewer: "Nosy",
          rating: 10,
          description: "dirty but good",
          product_id: product.id,
        },
      }
      expect {
        post product_reviews_path(product.id), params: bad_review
      }.wont_change "Review.count"

      must_respond_with :bad_request
    end

    it "assign Anonymous as the reviewer name if no name is enterred" do
      #create a bad review with an rating greater than 5
      bad_review = {
        "review": {
          reviewer: "",
          rating: 5,
          description: "dirty but good",
          product_id: product.id,
        },
      }
      post product_reviews_path(product.id), params: bad_review

      new_review = Review.find_by(description: "dirty but good")
      expect(new_review.reviewer).must_equal "Anonymous"
    end
  end
end
