class AddCaloriesToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :calories, :integer
  end
end
