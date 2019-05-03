class ProductsController < ApplicationController
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

  def retired
    product = Product.find_by(id: params[:id])

    product.toggle(:retired)
    product.save

    #is there another page we would want to fallback to? check test if we change.
    redirect_back(fallback_location: products_path)
  end
end
