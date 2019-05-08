class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :retired]
  before_action :find_product, only: [:show, :edit, :update, :retired]

  def index
    @products = Product.all
  end

  def show
    if @product.nil?
      flash[:error] = "Unknown product"

      redirect_to products_path
    end
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)

    product.merchant = @current_merchant

    is_successful = product.save

    if is_successful
      flash[:success] = "Product added successfully"
      redirect_to dashboard_path(product.merchant.id)
    else
      product.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  def edit
    if @product.nil?
      head :not_found
    end
  end

  def update
    if @product.nil?
      head :not_found
    else
      is_successful = @product.update(product_params)
      if is_successful
        flash[:success] = "Product updated successfully"
        redirect_to product_path(@product.id)
      else
        @product.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        render :edit, status: :bad_request
      end
    end
  end

  def retired
    if @product.nil?
      flash[:error] = "Product does not exist"
    else
      @product.toggle(:retired)
      @product.save
    end

    redirect_back(fallback_location: products_path)
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    return params.require(:product).permit(:name, :price, :description, :photo, :inventory, category_ids: [])
  end
end
