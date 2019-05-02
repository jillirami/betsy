require "test_helper"

describe MerchantsController do
  it "should get index" do
    get merchants_url
    value(response).must_be :successful?
  end

  describe "show" do
    it "should get show" do
      valid_merchant_id = merchants(:one_m).id

      get merchants_url(valid_merchant_id)
      value(response).must_be :successful?
    end

    it "should give a flash notice instead if invalid user" do
      invalid_id = merchants(:one_m).id
      merchants(:one_m).destroy

      get merchant_path(invalid_id)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown merchant"
    end
  end 
end
