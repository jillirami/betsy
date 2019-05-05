class OrdersController < ApplicationController
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
    order = Order.create
    session[:order_id] = @order.id
  end

  def edit
    @order = Order.find_by(id: session[:order_id])
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    is_successful = @order.update(order_params)

    if is_successful
      flash[:success] = "Thank you for placing your order!"
      session[:order_id] = nil
      redirect_to order_path(@order.id)
    else
      @order.errors.messages.each do |field, messages|
        flash.now[:error_form] = messages
      end
      render :edit, status: :bad_request
    end
  end

  # def create
  #   order = Order.new(order_params)

  #   is_successful = order.save

  #   if is_successful
  #     flash[:success] = "Thank you for placing an order!"
  #     redirect_to order_path(order.id)
  #   else
  #     order.errors.messages.each do |field, messages|
  #       flash.now[:error_form] = messages
  #     end

  #     render :new, status: :bad_request
  #   end
  # end

  private

  def order_params
    return params.require(:order).permit(:name, :email, :address, :cc_num, :cc_exp, :cc_cvv, :billing_zip)
  end
end
