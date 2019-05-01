require "test_helper"

describe ReviewsController do
  it "should get index" do
    get reviews_index_url
    value(response).must_be :success?
  end

end
