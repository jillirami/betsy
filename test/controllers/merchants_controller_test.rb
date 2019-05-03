require "test_helper"

describe MerchantsController do
  it "should get index" do
    get merchants_path
    value(response).must_be :successful?
  end

  it "display a list of all merchants in show" do
  end

  it "can log in an existing merchant" do
    merchant_count = Merchant.count
    merchant = merchants(:jewelry)

    perform_login(merchant)
    must_redirect_to root_path
    expect(Merchant.count).must_equal merchant_count
    # flash notices-- > :success

    expect(session[:merchant_id]).must_equal merchant.id
  end

  it "can log in a new merchant" do
    skip
    merchant = Merchant.new(provider: "github", uid: 909090, username: "merchant_test", email: "merchant@test.com", name: "merchant_test_name")

    expect {
      perform_login(merchant)
    }.must_change "Merchant.count", 1

    merchant = Merchant.find_by(uid: merchant.uid, provider: merchant.provider)
    # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
    # expect(flash[:success]).must_equal
    # #flash success

    expect(session[:merchant_id]).must_equal merchant.id
  end

  it "will redirect back to root with a flash message if not comming from github" do
    merchant = Merchant.new(provider: "github", uid: 1122, username: "merchant_test", email: "", name: "merchant_test_name")

    expect {
      perform_login(merchant)
    }.wont_change "Merchant.count"

    #flash error message test
  end

  describe "current" do
    it "responds with success if a merchant is logged in" do
      logged_in_merchant = perform_login
      get current_merchant_path
      must_respond_with :success
    end

    it "responds with a redirect if no merchant is logged in" do
      get current_merchant_path
      must_respond_with :redirect
    end
  end
  #   get merchants_url
  #   value(response).must_be :successful?
  # end

  describe "show" do
    it "should get show" do
      valid_merchant_id = merchants(:spices).id

      get merchants_url(valid_merchant_id)
      value(response).must_be :successful?
    end

    it "should give a flash notice instead if invalid user" do
      invalid_id = merchants(:spices).id
      merchants(:spices).destroy

      get merchant_path(invalid_id)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown merchant"
    end
  end
end
