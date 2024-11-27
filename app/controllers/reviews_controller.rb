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
    # @recipe = Recipe.find(params[:id])
    
    # if @recipe.update(recipe_params)
    #   redirect_to recipe_path(@recipe), notice: "Recipe updated!"
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  end

  def destroy
    # # find the Recipe item
    # @recipe = Recipe.find(params[:id])
    # # then destroy recipe
    # if @recipe.destroy
    #   redirect_to recipes_path, notice: "Recipe deleted"
    # else
    #   redirect_to recipe_path(@recipe), alert: "Can't delete recipe"
    # end
  end

  private

  def reviews_params
    
  end
end
