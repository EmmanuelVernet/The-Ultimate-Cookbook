class DropIngredientsAndRecipesIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :recipes_ingredients, :ingredients
    remove_foreign_key :recipes_ingredients, :recipes

    drop_table :recipes_ingredients do |t|
      t.bigint :recipe_id, null: false
      t.bigint :ingredient_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    drop_table :ingredients do |t|
      t.string :ingredient_name
      t.string :ingredient_category
      t.integer :calorie
      t.integer :protein
      t.integer :glucide
      t.integer :lipide
      t.integer :fibre
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
