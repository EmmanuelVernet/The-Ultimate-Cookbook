class Tag < ApplicationRecord
  has_and_belongs_to_many :recipes, join_table: 'tags_recipes', dependent: :destroy
  # https://guides.rubyonrails.org/active_record_validations.html#inclusion

end
