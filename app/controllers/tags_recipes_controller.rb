class TagsRecipesController < ApplicationController

  def create
    # recup la recette by ID
    recipe = Recipe.find(params[:recipe_id])
    # recup tag name prams[:tag][:name]
    tag = Tag.find(params[:name])
    # update recette => tag = prams[:tag][:name]
    if recipe.tags.exists?(id: tag.id)
      flash[:notice] = "Tag already exists for this recipe."
    else
      TagsRecipe.create(tag: tag, recipe: recipe)
    end
  end
end
