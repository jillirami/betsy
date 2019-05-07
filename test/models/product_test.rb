require "test_helper"

describe Product do
  let (:merchant) { merchants(:jewelry) }
  let (:product) { products(:one) }

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

      # Act
      product.merchant = merchant

      # Assert
      expect(product.merchant_id).must_equal merchant.id
    end

    it "can set the merchant through the merchant_id" do
      # Arrangec
      new_author = Author.create(name: "new author")

      # Act
      book.author_id = new_author.id

      # Assert
      expect(book.author).must_equal new_author
    end

    it "can have 0 genres" do

      # Act
      genres = book.genres

      # Assert
      expect(genres.length).must_equal 0
    end

    it "can have 1 or more genres by shoveling a genre into book.genres" do
      # Arrange
      new_genre = genres(:one)

      # Act
      book.genres << new_genre

      # Assert
      expect(new_genre.books).must_include book
    end
  end
end
