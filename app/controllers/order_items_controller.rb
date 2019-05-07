class OrderItemsController < ApplicationController
  # def index
  #   # @order_items = Orderitems.all.where(ord)
  # end

  def create
    if session[:order_id]
      @order = Order.find(session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end

    product = Product.find_by(id: params[:product_id])

    if params[:quantity].to_i > product.inventory
      flash[:error] = "Not enough #{product.name} in stock"
      return redirect_to product_path(product.id)
    else
      @order_item = Orderitem.new(quantity: params[:quantity], product_id: params[:product_id], order_id: @order.id)

      is_successful = @order_item.save

      new_inventory = (product.inventory - params[:quantity].to_i)
      product.update(inventory: new_inventory)
      
      if is_successful
        flash[:success] = "Item added to Cart"
        return redirect_to products_path
      else
        flash[:error] = "Could not add item to Cart"
        return redirect_to root_path
      end
    end
  end

  def edit
    @order_item = Orderitem.find_by(id: params[:id])

    if @order_item.nil?
      redirect_to order_path
    end
  end

  def update
    order_item = Orderitem.find_by(id: params[:id])
    order_id = order_item.order_id

    product = Product.find_by(id: order_item.product_id)

    if order_item.nil?
      redirect_to order_path(order_id)
    else
      if params[:quantity].to_i < order_item.quantity
        is_successful = order_item.update(quantity: params[:quantity])

        order_item_decrease = (order_item.quantity - params[:quantity].to_i)
        new_inventory = (product.inventory + order_item_decrease)
        product.update(inventory: new_inventory)
      elsif params[:quantity].to_i > order_item.quantity
        order_item_increase = (params[:quantity].to_i - order_item.quantity)
        if order_item_increase > product.inventory
          flash[:error] = "Not enough #{product.name} in stock"
          return redirect_to order_path(order_id)
        else
          is_successful = order_item.update(quantity: params[:quantity])

          new_inventory = (product.inventory - order_item_increase)
          product.update(inventory: new_inventory)
        end
      else
        return redirect_to order_path(order_id)
      end
    end

    if is_successful
      redirect_to order_path(order_id)
    end
  end

  def destroy
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
