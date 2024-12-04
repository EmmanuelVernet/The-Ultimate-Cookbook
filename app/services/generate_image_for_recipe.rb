class GenerateImageForRecipe
  def initialize(recipe)
    @recipe = recipe
  end

  def call
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
      prompt: "Create an appetizing, high-quality recipe image for a dish named #{@recipe.recipe_name}. The image should showcase the dish in a realistic setting, with proper lighting, garnishes, and presentation. Ensure the dish appears freshly cooked and visually appealing, without human presence and that the image is suitable for small spaces like thumbnails or mobile screens. Highlight the key ingredients and colors associated with the recipe if possible.", size: "256x256"
    })

    url = response["data"][0]["url"]
    file =  URI.parse(url).open

    @recipe.photo.purge if @recipe.photo.attached?
    @recipe.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    return @recipe
  end

end
