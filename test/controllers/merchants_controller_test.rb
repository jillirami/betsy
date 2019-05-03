require "test_helper"

describe MerchantsController do
  describe "index" do
    it "should get index" do
      get merchants_path
      value(response).must_be :successful?
    end
  end

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

  describe "create" do
    it "can log in an existing merchant" do
      merchant_count = Merchant.count
      merchant = merchants(:jewelry)

      perform_login(merchant)
      must_redirect_to root_path
      expect(Merchant.count).must_equal merchant_count
      expect(flash[:success]).must_equal "Logged in as a returning merchant #{merchant.username}"
      expect(session[:merchant_id]).must_equal merchant.id
    end

    it "can log in a new merchant" do
      start_count = Merchant.count
      merchant = Merchant.new(provider: "github", uid: 909090, username: "merchant_test", email: "merchant@test.com", name: "merchant_test_name")

      perform_login(merchant)

      must_redirect_to root_path
      merchant = Merchant.find_by(id: session[:merchant_id])
      Merchant.count.must_equal start_count + 1

      expect(flash[:success]).must_equal "Logged in as new merchant #{merchant.username}"
      expect(session[:merchant_id]).must_equal merchant.id
    end

    it "will redirect back to root with a flash message if not comming from github" do
      merchant = Merchant.new(provider: "github", uid: 1122, username: "merchant_test", email: "", name: "merchant_test_name")

      expect {
        perform_login(merchant)
      }.wont_change "Merchant.count"
      expect(flash[:error]).must_be_kind_of String
    end
  end

  describe "current" do
    it "responds with success if a merchant is logged in" do
      logged_in_merchant = perform_login
      get current_merchant_path
      must_respond_with :found
    end

    it "responds with a redirect if no merchant is logged in" do
      get current_merchant_path
      expect(flash[:error]).must_equal "Unknown merchant" # make the flash message match the current method in merchants controller - Myriam
      must_respond_with :redirect
    end
  end

  describe "logout" do
    it "will close the session an redirect to root path" do
      merchant = merchants(:jewelry)
      perform_login(merchant)
      delete logout_path
      must_respond_with :redirect
      expect(flash[:success]).must_equal "Successfully logged out, #{merchant.username}!"
    end
  end
end
