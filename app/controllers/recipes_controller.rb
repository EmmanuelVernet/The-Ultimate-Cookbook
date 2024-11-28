class RecipesController < ApplicationController
# Available routes => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!
  def index
    @recipes = Recipe.all
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      @recipe = user.recipes.find(params[:id])
    else
      @recipe = Recipe.find(params[:id])
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    # TO DO => handle recipes for a current_user
    @recipe = Recipe.create(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Recipe created!"
    else
      render :new, status: :unprocessable_entity
    end

    # TO DO => implement separate logic for OCR analysis with OpenAI
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "Recipe updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # find the Recipe item
    @recipe = Recipe.find(params[:id])
    # then destroy recipe
    if @recipe.destroy
      redirect_to recipes_path, notice: "Recipe deleted"
    else
      redirect_to recipe_path(@recipe), alert: "Can't delete recipe"
    end
  end

  def cookbook
    @recipes = current_user.recipes # cookbook action for a loged in user
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings, :recipe_steps, :recipe_likes, :favorite, :photo)
  end
end
