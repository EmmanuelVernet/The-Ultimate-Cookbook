class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipes_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipes_ingredients

  has_one_attached :photo
end
