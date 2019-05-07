class CategoriesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def new
    @category = Category.new(name: "Default category name")
  end

  def create
    category = Category.new(category_params)

    is_successful = category.save

    if is_successful
      flash[:success] = "Category successfully created"
      redirect_to categories_path
    else
      category.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def category_params
    return params.require(:category).permit(:name)
  end
end
