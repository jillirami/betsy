require "test_helper"

describe ProductsController do
  describe "index" do
    it "can get the index path" do
      get products_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid product" do
      product = products(:one)

      get product_path(product.id)

      must_respond_with :success
    end

    it "will respond with an error message if the product is invalid" do
      get product_path(-1)

      expect(flash[:error]).must_equal "Unknown product"
      must_redirect_to products_path
    end
  end
end