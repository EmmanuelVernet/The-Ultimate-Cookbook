class GenerateImageForRecipe
  def initialize(recipe)
    @recipe = recipe
  end

  def call
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
      prompt: "A recipe image of #{@recipe.recipe_name} It must look appetizing, try to find images that can fit little spaces", size: "256x256"
    })

    url = response["data"][0]["url"]
    file =  URI.parse(url).open

    @recipe.photo.purge if @recipe.photo.attached?
    @recipe.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    return @recipe
  end

end
