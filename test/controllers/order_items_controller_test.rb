require "test_helper"

describe OrderItemsController do
  describe "create" do
    it "will not create an order item if logged in as merchant" do
      merchant = merchants(:jewelry)

      perform_login(merchant)

      post order_items_path

      expect(flash[:error]).must_equal "Log out of your merchant account to shop!"
      must_respond_with :redirect
      must_redirect_to products_path
    end

    # it "will create an instance of an order if none already present" do
    #   session[:order]

            # Orderitem.create(quantity: 2, product_id: products(:two), order_id: orders(:order1))
    # end

  #   it "will not create an instance of an order if already present" do
  #   end

  #   it "can create an order item" do
  #   end

  #   it "reduced inventory of product when order created" do
  #   end

  #   it "will not create an order item if not enough inventory present" do
  #   end
  end

  # describe "edit" do
  # end

  # describe "update" do
  # end

  # describe "destroy" do
  # end

  # describe "random_create" do
  # end
end
