require "test_helper"

describe Product do
  let(:product) { Product.new }

  it "must be valid" do
    value(product).must_be :valid?
  end

  it "browses products by category" do
    category = categories(:cat1)
    product = Product.new(category_ids: [category.id])

    browse_result = Product.browse_by_category(category)

    expect(browse_result).must_be_kind_of ActiveRecord::Relation
    expect(product.category_ids).must_include category.id
  end
end
