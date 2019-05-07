require "test_helper"

describe OrdersController do
  describe "show" do
    it "should show order details for a valid order" do
      order = orders(:order1)
      get order_path(order.id)

      must_respond_with :success
    end

    it "will display an error and redirect for an invalid order" do
      get order_path(-1)

      expect(flash[:error]).must_equal "Unfound order"

      must_redirect_to root_path
    end
  end

  describe "create" do
    it "can successfully create a new order" do
      expect {
        post orders_path
      }.must_change "Order.count", 1

      expect(Order.last.status).must_equal "pending"
    end

    it "***what happens when invalid?*****" do
    end
  end
end
