class ProductsController < ApplicationController
  # before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      flash[:error] = "Unknown product"

      redirect_to products_path
    end
  end
end
