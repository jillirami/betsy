class OrderitemsController < ApplicationController
  # def index
  #   @orderitems = Orderitem.all.order(:id)
  # end

  def show
    @orderitems = current_order.orderitems
  end

  # def current_order
  #   if session[:order_id]
  # end

  def create
    # product_id = params[:id].to_i

    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.create
    end

    @orderitem = Orderitem.new(orderitem_params)
    # @orderitem.order = @order #, product_id: Product.find_by(id: params[:id]).id, order_id: order_id)  

    @orderitem.order_id = @order.id
    @orderitem.status = "SHIPPED"

    raise

    is_successful = @orderitem.save
    
    if is_successful
      flash[:success] = "Item added to Cart"
    else
      flash[:error] = "Could not add item to Cart"
      return redirect_to root_path
    end
  end

  def edit
    @orderitem = Orderitem.find_by(id: params[:id])

    if @orderitem.nil?
      redirect_to orderitems_path
    end
  end

  def update
    orderitem = Orderitem.find_by(id: params[:id])

    if orderitem.nil?
      redirect_to orderitems_path
    else
      is_successful = orderitem.update(orderitem_params)
    end

    if is_successful
      redirect_to orderitems_path
    end
  end

  def destroy
  end

  private

  def orderitem_params
    params.require(:orderitem).permit(:quantity, :product_id) # product_id: Product.find_by(id: params[:id]), order_id: Order.find_by(id: session[:order_id].id))
  end
end
  
  
  # # Create(-link to add to cart button)
  # # Only create an order item when there are inventory for the item being added to card
  # # Create the order item then in that method create a cart (find the cart first then create one if the cart is nil)
  # # Destroy
  # # Edit/Update(item can be removed from the cart or change quantity)
  # # Index(show a list of order a merchant needs to fulfill)
  
  # # Allow merchant to filter orders displayed by status
  # # Each order item sold by me with a quantity and line-item subtotal
  # # A link to the item description page
  # # DateTime the order was placed
  # # Link to transition the order item to marked as shipped
  # # The current status of the order ("pending", "paid", "complete", "cancelled")
