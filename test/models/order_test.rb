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

  describe "custom methods" do
    it "can synthesize duplicate orderitems in a cart" do
      orders(:two).orderitems << orderitems(:orderitem3)

      orders(:two).orderitems << orderitems(:orderitem4)

      expect(orders(:two).cart.length).must_equal 1
    end

    it "determines the total cost of the cart" do
      expect(orders(:two).cart_total).must_be_kind_of Integer
    end

    # it "returns how many items have shipped" do
      # orders(:two).orderitems << orderitems(:orderitem3)

      # orders(:two).orderitems << orderitems(:orderitem4)

      # orderitems(:orderitem3).update(status: false)
      # orderitems(:orderitem4).update(status: true)

      # expect(orders(:two).shipped_items).must_equal 1
    # end
  end
end
