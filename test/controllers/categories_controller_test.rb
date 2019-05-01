require "test_helper"

describe CategoriesController do
  it "should get index" do
    get categories_index_url
    value(response).must_be :success?
  end

end
