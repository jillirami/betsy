class ReviewsController < ApplicationController
  def new
    current_product_id = params[:product_id].to_i
    #if the merchant is locked in, check if any of the products belong to the merchant is the one getting reviewed
    if !@current_merchant.nil?
      if @current_merchant.product_ids.include? current_product_id
        flash[:error] = "You can't review your own product"
        redirect_to product_path(params[:product_id])
      end
    else
      @review = Review.new
    end
  end

  def create
    review = Review.new(review_params)
    #If the reviewer does not enter their name then assign their name to anonymous
    if review.reviewer == ""
      review.reviewer = "Anonymous"
    end

    review.product_id = Product.find_by(id: params[:product_id]).id

    if review.save
      flash[:success] = "Review successfully posted"
      redirect_to product_path(review.product_id)
    else
      review.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  private

  def review_params
    if !@current_merchant.nil?
      return params.permit(:reviewer, :rating, :description, :product_id)
    else
      return params.require(:review).permit(:reviewer, :rating, :description, :product_id)
    end
  end
end
