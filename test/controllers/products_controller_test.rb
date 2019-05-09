require "test_helper"

describe ProductsController do
  let(:existing_product) { products(:one) }

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
      must_redirect_to dashboard_path(merchants(:jewelry).id)

      new_product = Product.find_by(name: "Dirty Computer")

      expect(flash[:success]).must_equal "Product added successfully"
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

  describe "edit" do
    before do
      perform_login(merchants(:jewelry))
    end

    it "succeeds for an valid product ID" do
      get edit_product_path(existing_product.id)

      must_respond_with :success
    end

    it "renders 404 not_found for a bogus product ID" do
      bogus_id = -1

      get edit_product_path(bogus_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      perform_login(merchants(:jewelry))
    end

    it "succeeds for valid data and an extant product ID" do
      updates = { product: { name: "Medium Ring" } }

      expect {
        patch product_path(existing_product), params: updates
      }.wont_change "Product.count"
      updated_product = Product.find_by(id: existing_product.id)

      expect(flash[:success]).must_equal "Product updated successfully"
      updated_product.name.must_equal "Medium Ring"
      must_respond_with :redirect
      must_redirect_to product_path(existing_product.id)
    end

    it "renders bad_request for bogus data" do
      updates = { "product": { name: "" } }

      expect {
        patch product_path(existing_product), params: updates
      }.wont_change "Product.count"

      product = Product.find_by(id: existing_product.id)

      must_respond_with :bad_request
    end

    it "renders 404 not_found for a bogus product ID" do
      bogus_id = -1

      patch product_path(bogus_id), params: { product: { name: "Test Name" } }
      must_respond_with :not_found
    end
  end

  describe "retired" do
    before do
      perform_login(merchants(:jewelry))
    end
    it "can mark a product as retired, but changing the retired field from false to true" do
      product = products(:one)

      patch retired_product_path(product.id)
      product.reload
      must_redirect_to products_path

      expect(product.retired).must_equal true
    end
<<<<<<< HEAD
    it "renders flash error message for a bogus product ID" do
      bogus_id = -1
=======
>>>>>>> e7410946f4898efb90e37637cacfef9c0455977d

    it "renders flash error message for an invalid product ID" do
      patch retired_product_path(-1)
      expect(flash[:error]).must_equal "Product does not exist"
    end
  end
end
