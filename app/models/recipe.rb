require "open-uri"
class Recipe < ApplicationRecord
  include PgSearch::Model
  # Example: Use JSON for structured ingredients
  # serialize :ingredients, JSON
  belongs_to :user
  has_many :received_recipes, through: :shares, source: :recipe
  has_and_belongs_to_many :tags, join_table: 'tags_recipes'

  has_one_attached :photo

  pg_search_scope :search_by_all_attributes,
    against: [ :recipe_name, :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings, :ingredients],
    using: {
      tsearch: { prefix: true }
    }

    def set_photo
      client = OpenAI::Client.new
      response = client.images.generate(parameters: {
        prompt: "A recipe image of #{self.recipe_name}", size: "256x256"
      })

      url = response["data"][0]["url"]
      file =  URI.parse(url).open

      self.photo.purge if self.photo.attached?
      self.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
      return photo
    end

    private

    def set_content
      RecipeContentJob.perform_later(self)
    end

end
