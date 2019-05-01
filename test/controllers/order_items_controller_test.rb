require "test_helper"

describe OrderItemsController do
  it "should get index" do
    get order_items_index_url
    value(response).must_be :success?
  end

end
