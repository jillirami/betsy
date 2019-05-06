class OrdersController < ApplicationController
  def show
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      flash[:error] = "Unfound order"

      redirect_to root_path
    end
  end

  def edit
    order = Order.create
    session[:order_id] = order.id
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

  private

  def order_params
    return params.require(:order).permit(:name, :email, :address, :cc_num, :cc_exp, :cc_cvv, :billing_zip)
  end
end
