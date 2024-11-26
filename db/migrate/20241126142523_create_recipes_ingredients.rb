class CreateRecipesIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes_ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
