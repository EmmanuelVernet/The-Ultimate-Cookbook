class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :ingredient_name
      t.string :ingredient_category
      t.integer :calorie
      t.integer :protein
      t.integer :glucide
      t.integer :lipide
      t.integer :fibre

      t.timestamps
    end
  end
end
