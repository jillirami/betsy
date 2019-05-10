require "test_helper"

describe Category do
  let(:category) { categories(:cat1) }
  let(:product) { products(:one) }

  it "must be valid" do
    value(category).must_be :valid?
  end

  describe "validations" do
    it "requires a name" do
      category = Category.new(name: "")
      category.valid?.must_equal false
      category.errors.messages.must_include :name
    end
  end

  describe "relationships" do
    it "belongs to a product" do
      product.categories << category
      expect(product.categories[0].name).must_equal category.name
    end

    it "can have 0 product" do
      expect(category.products.length).must_equal 0
    end

    it "has many products" do
      category.products << products(:one)
      category.products << products(:two)

      expect(category.products).must_include products(:one)
      expect(category.products).must_include products(:two)
    end
  end
end
