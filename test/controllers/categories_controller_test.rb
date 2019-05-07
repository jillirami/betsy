require "test_helper"

describe CategoriesController do
  describe "index" do
    it "should get index" do
      perform_login(merchants(:jewelry))
      get categories_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "responds with success" do
      perform_login(merchants(:jewelry))
      get new_category_path
      must_respond_with :success
    end

    it "respond with redirect when merchant is not logged in" do
      get new_category_path
      must_respond_with :redirect
    end
  end

  describe "create" do
    before do
      perform_login(merchants(:jewelry))
    end

    it "successfully creates a category" do
      new_category_input = {
        "category": {
          name: "plants",
        },
      }

      expect {
        post categories_path, params: new_category_input
      }.must_change "Category.count", 1

      new_category = Category.find_by(name: "plants")

      expect(new_category).wont_be_nil
      expect(new_category.name).must_equal new_category_input[:category][:name]
    end

    it "renders bad_request and does not update the DB for bogus data" do
      new_category_input = {
        "category": {
          name: "",
        },
      }

      expect {
        post categories_path, params: new_category_input
      }.wont_change "Category.count"

      new_category = Category.find_by(name: "plants")

      expect(new_category).must_equal nil
    end
  end
end
