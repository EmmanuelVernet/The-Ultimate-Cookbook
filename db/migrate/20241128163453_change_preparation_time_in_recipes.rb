class ChangePreparationTimeInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :preparation_time, :string
  end
end
