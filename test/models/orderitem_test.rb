require "test_helper"

describe Orderitem do
  let(:orderitem) { orderitems(:orderitem1) }

  it "must be valid" do
    value(orderitem).must_be :valid?
  end

  describe "relations" do
    it "belongs to a product" do
      orderitem.must_respond_to :product
      expect(Product.find_by(id: orderitem.product_id)).must_be_kind_of Product
    end

    it "belongs to an order" do
      orderitem.must_respond_to :order
      expect(Order.find_by(id: orderitem.order_id)).must_be_kind_of Order
    end
  end

  describe "custom methods" do
    it "calculated the subtotal of the orderitem with specified quantity" do
      expect(orderitems(:realorderitem).subtotal).must_equal 200
      expect(orderitems(:realorderitem).subtotal).must_be_kind_of Integer
    end

    it "adjusts quantity of product by the requested quantity" do
      order_item = orderitems(:modelorderitem3)
      previous_quantity = order_item.quantity
      
      order_item.adjust_quantity_by!(3)

      expect(previous_quantity - order_item.quantity).must_equal 1
    end
  end
end
