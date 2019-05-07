require "test_helper"

describe Product do
  let (:merchant) { merchants(:jewelry) }
  let (:product) { products(:one) }
  let (:category) { categories(:cat1) }

  it "must be valid" do
    valid_product = product.valid?

    expect(valid_product).must_equal true
  end

  describe "validations" do
    it "requires a name" do
      product = Product.new(price: 30)
      product.valid?.must_equal false
      product.errors.messages.must_include :name
    end

    it "requires unique names" do
      name = "test name"
      price = 30
      product1 = Product.new(name: name, price: price, merchant_id: merchant.id)
      product1.save!

      product2 = Product.new(name: name, price: price, merchant_id: merchant.id)
      product2.valid?.must_equal false
      product2.errors.messages.must_include :name
    end

    it "requires a price" do
      product = Product.new(name: "test name")
      product.valid?.must_equal false
      product.errors.messages.must_include :price
    end

    it "requires price input to be integer" do
      name = "test name"
      price = "thirty"
      product1 = Product.new(name: name, price: price, merchant_id: merchant.id)

      product1.valid?.must_equal false
      product1.errors.messages.must_include :price
    end
  end

  describe "relationships" do
    it "belongs to an merchant" do
      product.merchant = merchant

      expect(product.merchant_id).must_equal merchant.id
    end

    it "can set the merchant through the merchant_id" do
      product.merchant_id = merchant.id

      expect(product.merchant).must_equal merchant
    end

    it "can have 0 category" do
      categories = product.categories

      expect(categories.length).must_equal 0
    end

    it "can have 1 or more category by shoveling a category into product.categories" do
      product.categories << category

      expect(product.categories).must_include category
    end
  end

  it "browses products by category" do
    category = categories(:cat1)
    product = Product.new(category_ids: [category.id])

    browse_result = Product.browse_by_category(category)

    expect(browse_result).must_be_kind_of ActiveRecord::Relation
    expect(product.category_ids).must_include category.id
  end
end
