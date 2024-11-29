class Recipe < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :recipes_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipes_ingredients

  has_one_attached :photo

  pg_search_scope :search_by_all_attributes,
    against: [ :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings ],
    associated_against: {
      ingredients: [ :ingredient_name, :ingredient_category ]
    },
    using: {
      tsearch: { prefix: true }
    }

end
