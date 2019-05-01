require "test_helper"

describe OrdersController do
  it "should get index" do
    get orders_index_url
    value(response).must_be :success?
  end

end
