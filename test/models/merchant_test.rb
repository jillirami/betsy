require "test_helper"

describe Merchant do
  let(:merchant) { Merchant.new }

  it "can create a new merchant" do
    expect(merchant).must_be_instance_of Merchant
  end

  describe "build_from_github" do
    it "sucessfully builds auth hash" do
      merchant = merchants(:jewelry)

      fake_auth_hash = {
        "provider" => merchant.provider,
        uid: merchant.uid,
        "info" => {
          "email" => merchant.email,
          "nickname" => merchant.username,
          "name" => merchant.name,
        },
      }

      merchant = Merchant.build_from_github(fake_auth_hash)
      expect(merchant).must_be_instance_of Merchant
    end
  end

  describe "find_order_items" do
    it "finds the order items when given a merchant and a status" do
      merchant = merchants(:jewelry)

      status = "pending"
      order_items = Merchant.find_order_items(merchant, status)
      expect(order_items).must_be_kind_of Array
      expect(order_items.first).must_be_instance_of Orderitem
    end

    it "returns an empty array when no order items where found" do
      merchant = merchants(:bottles)
      status = "not a valid status"
      order_items = Merchant.find_order_items(merchant, status)
      expect(order_items).must_be_kind_of Array
      expect(order_items.empty?).must_equal true
    end
  end

  describe "find_order_by_status" do
    it "finds the order by the status" do
      order_item = orderitems(:orderitem1)
      status = "pending"
      result = Merchant.find_order_by_status(order_item, status)
      expect(result).must_be_instance_of Order
    end
    it "returns false when the order doesn't match the status" do
      order_item = orderitems(:orderitem1)
      status = "paid"
      result = Merchant.find_order_by_status(order_item, status)
      expect(result).must_equal false
    end
  end

  describe "calculate_subtotal" do
    it "can calculate subtotal" do
      order_item = orderitems(:orderitem1)
      subtotal = Merchant.calculate_subtotal(order_item)
      expect(subtotal).must_be_kind_of Float
    end

    it "returns false if there is not a valid order item" do
      order_item = ""
      subtotal = Merchant.calculate_subtotal(order_item)
      expect(subtotal).must_equal false
    end
  end
end
