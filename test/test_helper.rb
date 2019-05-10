
require "simplecov"
SimpleCov.start "rails"
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
  def setup
    # Tell OmniAuth Gem that we're in Test Mode
    OmniAuth.config.test_mode = true
  end

  def mock_auth_hash(merchant)
    return {
             provider: merchant.provider,
             uid: merchant.uid,
             info: {
               email: merchant.email,
               nickname: merchant.username,
               name: merchant.name,
             },
           }
  end

  def perform_login(merchant = nil)
    merchant ||= merchants(:spices)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))
    get auth_callback_path(:github)

    must_respond_with :redirect
    must_redirect_to root_path

    return merchant
  end

  def new_order
    product = products(:one)

    item_hash = {
      quantity: 1,
      product_id: product.id,
    }

    post order_items_path, params: item_hash
    return order
  end
end
