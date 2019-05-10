class OrderItemsController < ApplicationController
  def create
    if session[:merchant_id]
      flash[:error] = "Log out of your merchant account to shop!"
      redirect_to products_path
    else
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
        order_item_decrease = (order_item.quantity - params[:quantity].to_i)
        increase_inventory = (product.inventory + order_item_decrease)
        product.update(inventory: increase_inventory)

        is_successful = order_item.update(quantity: params[:quantity])

        if is_successful
          redirect_to order_path(order_id)
        end
      elsif params[:quantity].to_i > order_item.quantity
        order_item_increase = (params[:quantity].to_i - order_item.quantity)

        if order_item_increase > product.inventory
          flash[:error] = "Not enough #{product.name} in stock"
          return redirect_to order_path(order_id)
        else
          is_successful = order_item.update(quantity: params[:quantity])

          decrease_inventory = (product.inventory - order_item_increase)
          product.update(inventory: decrease_inventory)

          if is_successful
            redirect_to order_path(order_id)
          end
        end
      else
        return redirect_to order_path(order_id)
      end
    end
  end

  def destroy
    @order_item = Orderitem.find_by(id: params[:id])
    @order = Order.find_by(id: @order_item.order_id)
    product = Product.find_by(id: @order_item.product_id)

    if @order_item.nil?
      flash[:error] = "This order item does not exist"
    else
      returned_inventory = (product.inventory + @order_item.quantity)
      product.update(inventory: returned_inventory)

      deleted_orders = Orderitem.where(product_id: @order_item.product_id)

      deleted_orders.each do |delete_order|
        delete_order.destroy
      end

      flash[:success] = "Item removed from Cart"
      redirect_to order_path(@order.id)
    end
  end

  def random_create
    order = Order.find(session[:order_id])

    @order_item = Orderitem.create(quantity: 1, product_id: Product.all.sample.id, order_id: order.id)

    random_product = Product.find_by(id: @order_item.product_id)
    random_product.update(inventory: (random_product.inventory - 1))

    order.orderitems << @order_item
    return redirect_to order_path(order.id)
  end

  def shipment
    @order_item = Orderitem.find_by(id: params[:id])
    if @order_item.nil?
      flash[:error] = "Order item does not exist"
    else
      @order_item.toggle!(:status)

      unshipped_order = 0

      current_order = Order.find_by(id: @order_item.order_id)
      order_count = current_order.orderitems.length

      current_order.orderitems.each do |order_item|
        if order_item.status == false
          unshipped_order += 1
        end
      end

      if unshipped_order == 0
        current_order.update(status: "complete")
      elsif unshipped_order <= order_count
        current_order.update(status: "paid")
      end
    end
    redirect_back(fallback_location: dashboard_orders_path)
  end
end
