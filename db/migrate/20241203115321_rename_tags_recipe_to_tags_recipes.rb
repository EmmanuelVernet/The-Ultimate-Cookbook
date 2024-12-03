class RenameTagsRecipeToTagsRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_table :tags_recipe, :tags_recipes
  end 
end
