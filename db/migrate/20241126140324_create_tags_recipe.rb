class CreateTagsRecipe < ActiveRecord::Migration[7.1]
  def change
    create_table :tags_recipe do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
