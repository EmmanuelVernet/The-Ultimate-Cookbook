class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.text :recipe_overview
      t.string :recipe_category
      t.time :preparation_time
      t.string :difficulty
      t.string :import_source
      t.integer :servings
      t.text :recipe_steps
      t.integer :recipe_likes
      t.boolean :favorite
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
