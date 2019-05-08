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
      new_order

      order_hash = {
        order: {
          name: "my name",
          email: "myname@gmail.com",
          address: "address",
          cc_num: 1235,
          cc_exp: 1219,
          cc_cvv: 999,
          billing_zip: 10000,
        },
      }

      expect { patch order_path(order.id), params: order_hash }.wont_change "Order.count"

      updated_order = Order.find_by(name: "my name")

      expect(flash[:success]).must_equal "Thank you for placing your order!"
      expect(updated_order.status).must_equal "paid"
      must_redirect_to receipt_path(updated_order.id)
    end
  end

  describe "cancel" do
    it "can cancel and order and set status to 'cancelled'" do
      new_order

      patch cancel_order_path(order.id)

      expect(flash[:success]).must_equal "This order has been cancelled"
      must_redirect_to root_path
    end
  end

  describe "receipt" do
    it "will set session to nil" do
      product = products(:one)

      item_hash = {
        quantity: 1,
        product_id: product.id,
      }

      get receipt_path(order.id)

      must_respond_with :success
    end
  end
end
