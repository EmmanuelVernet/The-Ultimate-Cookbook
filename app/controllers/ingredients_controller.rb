class IngredientsController < ApplicationController

  def index
    if params[:recipe_id] # If nested route for a recipe
      @recipe = Recipe.find(params[:recipe_id])
      @ingredients = @recipe.ingredients # Filter by recipe
    else
      @ingredients = Ingredient.all # Get all ingredients
    end
  end

  def show
    if params[:recipe_id] # If nested route for a recipe
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.find(params[:id]) # Get ingredients linked to recipes
    else
      @ingredient = Ingredient.find(params[:id]) # Get the ingredient only
    end
  end
  
  def new 
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.create(ingredient_params)

    if @ingredient.save
      redirect_to ingredient_path(@ingredient), notice: "Ingredient created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path(@ingredient), notice: "Ingredient updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # find the ingredient item
    @ingredient = Ingredient.find(params[:id])
    # then destroy
    @ingredient.destroy
    redirect_to ingredient_path, notice: "Ingredient deleted"
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_name, :ingredient_category, :calorie, :protein, :glucide, :lipide, :fibre)
  end
end
