class OrdersController < ApplicationController
  def show
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      flash[:error] = "Unfound order"

      redirect_to root_path
    end
  end

  def edit
    @order = Order.find_by(id: session[:order_id])
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    @order.status = "paid"
    is_successful = @order.update(order_params)

    if is_successful
      flash[:success] = "Thank you for placing your order!"
      redirect_to receipt_path(@order.id)
    else
      @order.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def cancel
    @order = Order.find_by(id: session[:order_id])
    @order.status = "cancelled"
    @order.save
    session[:order_id] = nil
    flash[:success] = "This order has been cancelled"

    redirect_to root_path
  end

  def receipt
    @order = Order.find_by(id: params[:id])
    session[:order_id] = nil
  end

  private

  def order_params
    return params.require(:order).permit(:name, :email, :address, :cc_num, :cc_exp, :cc_cvv, :billing_zip, :status)
  end
end
