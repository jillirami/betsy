require "test_helper"

describe OrdersController do
  let(:order) { orders(:order1) }

  describe "show" do
    it "should show order details for a valid order" do
      get order_path(order.id)

      must_respond_with :success
    end

    it "will display an error and redirect for an invalid order" do
      get order_path(-1)

      expect(flash[:error]).must_equal "Unfound order"

      must_redirect_to root_path
    end
  end

  describe "edit" do
    it "can find a valid order" do
      get order_path(order.id)

      must_respond_with :success
    end
  end

  describe "update" do
    it "can update an existing order" do
      # order_session

      product = products(:one)

      item_hash = {
        quantity: 1,
        product_id: product.id,
        order_id: order.id,
      }

      expect { post order_items_path, params: item_hash }.must_change "Orderitem.count", 1

      # order_hash = {
      #   order: {
      #     name: "my name",
      #     email: "myname@gmail.com",
      #     address: "address",
      #     cc_num: 1235,
      #     cc_exp: 1219,
      #     cc_cvv: 999,
      #     billing_zip: 10000,
      #   },
      # }

      # expect { patch order_path(session[:order_id]), params: order_hash }.wont_change "Order.count"

      # order.reload
      # expect(order.status).must_equal "pending"
    end
  end
end
