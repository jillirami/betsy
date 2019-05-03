class OrdersController < ApplicationController
  def index
    # I think we can delete this
    @orders = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      flash[:error] = "Unfound order"

      redirect_to root_path
    end
  end

  def new
    @order = Order.new

  end

  def create
  end


end
