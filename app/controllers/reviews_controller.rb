class ReviewsController < ApplicationController
  # def index
  # end

  def new
    @review = Review.new #(description: "Default Review", product_id: params[:product_id])

    if params[:product_id]
      @review.product_id = Product.find_by(id: params[:product_id]).id
    end
  end

  def create
    review = Review.new(review_params)

    if review.save
      flash[:success] = "Successfully created review!"
      redirect_to root_path #product_reviews_path(product.id) #review_path(product.params[:product_id])
    else
      flash[:failure] = "Could not create review"
      flash[:messages] = review.errors.messages
      render :new, status: :bad_request
    end
  end

  private

  def review_params
    return params.require(:review).permit(:rating, :description, :product_id)
  end
end
#