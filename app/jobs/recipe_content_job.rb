class RecipeContentJob < ApplicationJob
  queue_as :default

  def perform(recipe)
    # Do something later => code for calling Open AI
  end
end
