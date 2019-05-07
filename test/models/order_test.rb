require "test_helper"

describe Order do
  let(:order) { orders(:order1) }

  it "must be valid" do
    expect(order).must_be :valid?
  end

  describe "relations" do
    it "has a list of order items" do
      order.must_respond_to :orderitems
      order.orderitems.each do |cart_item|
        cart_item.must_be_kind_of Orderitem
      end
    end
  end
end
