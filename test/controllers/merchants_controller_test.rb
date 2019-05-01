require "test_helper"

describe MerchantsController do
  it "should get index" do
    get merchants_index_url
    value(response).must_be :success?
  end

end
