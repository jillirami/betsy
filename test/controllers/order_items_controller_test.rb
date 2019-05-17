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

    it "will create an instance of an order if none already present" do
      new_order = {
        quantity: 225,
        product_id: products(:fourjr).id,
      }

      expect { post order_items_path, params: new_order }.must_change "Order.count", 1
    end

    it "will not create an order item if not enough inventory present" do
      product = products(:three)
      
      orderitem = {
        quantity: 50000,
        product_id: product.id,
        order_id: orders(:neworder).id,
      }

      expect {
        post order_items_path, params: orderitem
      }.wont_change "Orderitem.count"

      expect(flash[:error]).must_equal "Not enough #{product.name} in stock"

      must_respond_with :redirect
      must_redirect_to product_path(product.id)
    end
  end

  describe "update" do
    it "will redirect if order_item not found" do
      orderitem_quan = {
        quantity: 2,
      }

      patch order_item_path(-1), params: orderitem_quan
      
      expect(flash[:error]).must_equal "Order item not found"
      must_respond_with :redirect
      must_redirect_to products_path
    end

    it "will flash error if order can not be updated with requested quantity" do
      order_item = orderitems(:realorderitem2)

      orderitem_quan = {
        quantity: 10000000,
      }

      patch order_item_path(order_item), params: orderitem_quan
      
      expect(flash[:error]).must_equal "Not enough #{order_item.product.name} in stock"
      must_respond_with :redirect
      must_redirect_to order_path(order_item.order)
    end

    it "will update an order item quantity" do
      order_item = orderitems(:updateorderitem)
      previous_quan = order_item.quantity

      orderitem_quan = {
        quantity: 1,
      }

      expect{patch order_item_path(order_item.id), params: orderitem_quan}.wont_change "Orderitem.count"

      must_redirect_to order_path(order_item.order)
    end
  end

  describe "destroy" do
    it "destroys an order item from the cart" do
      orders(:two).orderitems << orderitems(:deleteme)

      delete_orderitem = orderitems(:deleteme)

      expect {
        delete order_item_path(delete_orderitem.id)
      }.must_change "Orderitem.count", -1

      expect(flash[:success]).must_equal "Item removed from Cart"
      must_respond_with :redirect
    end

    it "will destroy multiple orderitems if associated by product" do
      orders(:three).orderitems << orderitems(:realorderitem)
      orders(:three).orderitems << orderitems(:realorderitem2)

      delete_orderitem = orderitems(:realorderitem)

      expect{delete order_item_path(delete_orderitem.id)}.must_change "Orderitem.count", -2

      expect(flash[:success]).must_equal "Item removed from Cart"
      must_respond_with :redirect
    end
  end

  # describe "random_create" do
  #   it "produced a random order item" do
  #     order = orders(:neworder)

  #     expect {
  #             post random_path, params: order
  #           }.must_change "Orderitem.count", 1
  #   end
  # end

  # describe "shipment" do
  #   it "adjusted order item status" do
  #     orderitem = orderitems(:modelorderitem2)

  #     patch shipment_path(orderitem.id)
  #     expect(orderitem.status).must_equal true
  #   end
  # end
end






    # it "will not create an instance of an order if already present" do
    #   no_new_order = {
    #     quantity: 50,
    #     product_id: products(:three).id,
    #     order_id: orders(:neworder).id,
    #   }

    #   expect{ post order_items_path, params: no_new_order }.wont_change "Orderitem.count"
    # end

    # it "can create an order item" do
    #   newer_order = {
    #     quantity: 50,
    #     product_id: products(:fourjr).id,
    #     order_id: orders(:neworder).id,
    #   }

    #   expect { post order_items_path, params: newer_order }.must_change "Orderitem.count", 1
    # end
  

  # #   it "reduced inventory of product when order created" do
  # #   end