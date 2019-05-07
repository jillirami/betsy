class OrdersController < ApplicationController
  def show
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      flash[:error] = "Unfound order"

      redirect_to root_path
    end
  end

<<<<<<< HEAD
  # def new
  #   @order = Order.new
  # end

  def create
    @order = Order.create
    session[:order_id] = @order.id
    # @order = Order.new(id: session[order_id])
    # if (@order.save)
    #   redirect_to :action => :index
    # else
    #   render :action => :new
    # end
  end

=======
>>>>>>> master
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

<<<<<<< HEAD
  def destroy
    @order = Order.find_by(id: session[:order_id])
    @order.status = "cancelled"
    @order.save
    session[:order_id] = nil
    flash[:success] = "This order has been cancelled"

    redirect_to root_path
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
=======
  def receipt
    @order = Order.find_by(id: params[:id])
    session[:order_id] = nil
  end
>>>>>>> master

  private

  def order_params
    return params.require(:order).permit(:name, :email, :address, :cc_num, :cc_exp, :cc_cvv, :billing_zip, status: "paid")
  end
end
