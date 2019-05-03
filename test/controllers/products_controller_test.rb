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

  describe "retired" do
    it "can mark a product as retired, but changing the retired field from false to true" do
      product = products(:one)

      expect(product.retired).must_equal false

      patch retired_product_path(product.id)
      product.reload

      expect(product.retired).must_equal true
      must_redirect_to products_path
    end
  end
end
