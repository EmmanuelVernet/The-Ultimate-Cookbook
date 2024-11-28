class RecipesController < ApplicationController
# Available routes => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!
  def index
    @user_recipes = Recipe.where(user_id: current_user.id)
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

  def add_to_coobook
    # get the recipe by ID
    original_recipe = Recipe.find(params[:id])
    
    # store it in a variable and duplicate the recipe for the current user
    new_user_recipe = original_recipe.dup
    new_user_recipe.user_id = current_user.id

    if new_user_recipe.save
      redirect_to cookbook_recipes_path, notice: "Recette ajoutée!"
    else
      redirect_to recipe_path(original_recipe), alert: "Impossible d'ajouter la recette"
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings, :recipe_steps, :recipe_likes, :favorite, :photo)
  end
end
