class CreateRecipeFromImageJob < ApplicationJob
  queue_as :default

  def perform(image, user)
    CreateRecipeFromImage.new(image, user).call
  end
end
# CreateRecipeFromImageJob.perform_later(image)
