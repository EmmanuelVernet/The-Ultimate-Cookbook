class AddIngredientsToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :ingredients, :text
  end
end
