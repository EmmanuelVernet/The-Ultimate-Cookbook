class ReviewsController < ApplicationController
  # only: [:show, :create, :update, :destroy]
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.create(review_params)

    if @review.save
      redirect_to review_path(@review), notice: "Your review was created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @review = Review.find(params[:id])
    
    if @review.update(review_params)
      redirect_to review_path(@review), notice: "Review updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # find the Review item
    @review = Review.find(params[:id])
    # then destroy review
    if @review.destroy
      redirect_to review_path, notice: "Review deleted"
    else
      redirect_to review_path(@review), alert: "Can't delete review"
    end
  end

  private

  def reviews_params
    params.require(:review).permit(:user_id, :recipe_id, :comment, :star, :date)
  end
end
