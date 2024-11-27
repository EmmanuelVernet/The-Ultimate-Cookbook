class RecipesController < ApplicationController
# Available routes => [:index, :show, :new, :edit, :create, :update, :destroy]
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
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

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings, :recipe_steps, :recipe_likes, :favorite)
  end
end







# create_table "recipes", force: :cascade do |t|
#   t.string "recipe_name"
#   t.text "recipe_overview"
#   t.string "recipe_category"
#   t.time "preparation_time"
#   t.string "difficulty"
#   t.string "import_source"
#   t.integer "servings"
#   t.text "recipe_steps"
#   t.integer "recipe_likes"
#   t.boolean "favorite"
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_recipes_on_user_id"
# end