class ReviewsController < ApplicationController
  def new
    current_product_id = params[:product_id].to_i
    if @current_merchant.product_ids.include? current_product_id
      flash[:error] = "You can't review your own product"
      redirect_to product_path(params[:product_id])
    else
      @review = Review.new
    end
  end

  def create
    review = Review.new(review_params)
    if review.reviewer.nil?
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
    return params.require(:review).permit(:name, :rating, :description, :product_id)
  end
end
