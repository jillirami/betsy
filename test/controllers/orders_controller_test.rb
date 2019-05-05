require "test_helper"

describe OrdersController do
  describe "show" do
    it "should show order details for a valid order" do
      order = orders(:pending)
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
    end
  end
end
