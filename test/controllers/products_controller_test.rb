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

  describe "new" do
    it "succeeds" do
      perform_login(merchants(:jewelry))

      get new_product_path

      must_respond_with :success
    end
  end

  describe "create" do
    before do
      perform_login(merchants(:jewelry))
    end
    it "creates a product with valid data for a real category" do
      new_product_input = {
        "product": {
          name: "Dirty Computer",
          price: 400,
          description: "dirty but good",
          photo: "photo url",
          inventory: 20,
          merchant_id: merchants(:jewelry).id,
        },
      }

      expect {
        post products_path, params: new_product_input
      }.must_change "Product.count", 1

      new_product_id = Product.find_by(name: "Dirty Computer").id

      must_respond_with :redirect
      must_redirect_to product_path(new_product_id)

      new_product = Product.find_by(name: "Dirty Computer")
      p new_product

      expect(new_product).wont_be_nil
      expect(new_product.name).must_equal new_product_input[:product][:name]
      expect(new_product.price).must_equal new_product_input[:product][:price]
      expect(new_product.description).must_equal new_product_input[:product][:description]
      expect(new_product.photo).must_equal new_product_input[:product][:photo]
      expect(new_product.inventory).must_equal new_product_input[:product][:inventory]
    end

    it "renders bad_request and does not update the DB for bogus data" do
      #create a bad product with an empty name
      bad_product = {
        "product": {
          name: "",
          price: 200,
          description: "dirty but good",
          photo: "photo url",
          inventory: 20,
          merchant_id: Merchant.first.id,
        },
      }
      expect {
        post products_path, params: bad_product
      }.wont_change "Product.count"

      must_respond_with :bad_request
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
