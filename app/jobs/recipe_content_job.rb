class RecipeContentJob < ApplicationJob
  queue_as :default

  def perform(recipe_id)
    recipe = Recipe.find(recipe_id)

    ocr_result = recipe.extract_text_from_image

    dalle_result = recipe.generate_dalle_image(ocr_result)


    recipe.update(ocr_result: ocr_result)

    # Attach the DALL-E generated image to the recipe
    recipe.photo.purge if recipe.photo.attached? # Clear old photo if present
    recipe.photo.attach(io: dalle_result, filename: "ai_generated_image.jpg", content_type: "image/png")
  end
end
