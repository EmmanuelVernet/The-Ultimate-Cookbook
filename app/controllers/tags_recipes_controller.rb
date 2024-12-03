class TagsRecipesController < ApplicationController

  def create
    # recup la recette by ID
    recipe = Recipe.find(params[:recipe_id])
    # recup tag name prams[:tag][:name]
    tag = Tag.find(params[:name])
    # update recette => tag = prams[:tag][:name]
    TagsRecipe.create(tag: tag, recipe: recipe)
  end
end
