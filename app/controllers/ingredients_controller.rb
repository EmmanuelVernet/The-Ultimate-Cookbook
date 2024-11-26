class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end
  
  def new 
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.create(ingredient_params)
    @ingredient.save
    # TODO
    # if @ingredient.save
    #   redirect_to ingredient_path(@ingredient), notice: "Igredient was successfully created."
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(ingredient_params)
    redirect_to ingredient_path(@ingredient)
    # TO DO => add safe guards with if statement
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