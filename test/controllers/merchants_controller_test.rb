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

    merchant = perform_login(merchants(:jewelry))

    expect(merchant_count).must_equal Merchant.count
    # flash notices-- > :success

    expect(session[:merchant_id]).must_equal merchant.id
  end

  it "can log in a new merchant" do
    skip
    merchant = Merchant.new(provider: "github", uid: 909090, username: "merchant_test", email: "merchant@test.com", name: "merchant_test_name")
    # merchant.save
    expect {
      perform_login(merchant)
    }.must_change "Merchant.count", 1

    merchant = Merchant.find_by(uid: merchant.uid, provider: merchant.provider)

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

      # Arrange: We have to log in as a user by NOT manipulating session... we will do a login action!
      logged_in_merchant = perform_login

      # Act: We need to still make a request to get to the users controller current action
      get current_merchant_path

      # Assert: Check that it responds with success
      must_respond_with :success
    end

    it "responds with a redirect if no merchant is logged in" do
      get current_merchant_path
      must_respond_with :redirect
    end
  end
end
