class CreateRecipeFromImage
  def initialize(image, user)
    @image = image
    @user = user
  end

  def call
    @recipe = Recipe.new
    @recipe.photo.attach(@image)

    
    if @recipe.photo.attached?
      # Force public access for the image during upload
      Cloudinary::Uploader.upload(@image.tempfile, public_id: @recipe.photo.filename.to_s, access_mode: 'public')

      # Retrieve the public URL of the uploaded image
      image_url = Cloudinary::Utils.cloudinary_url(@recipe.photo.filename.to_s, format: :jpg)

      begin

        # Initialize OpenAI client
        client = OpenAI::Client.new


        # Send extracted text to OpenAI for recipe parsing
        chatgpt_response = client.chat(
          parameters: {
            model: "gpt-4o-mini",
            messages: [
              {
                "role": "user",
                "content": [
                  {
                    "type": "text",
                    "text": " Analyze the image find the informations about the recipe image sent and respond with a Ruby hash containing the following keys: :name (format title max 19 characters, crop if necessary), :recipe_overview (If there is a short description of the recipe), :category (if there is a category starter, main course, otherwise extrapolate one), :ingredients (as an array of ingredients),  :preparation_time (time to cook the recipe (ex format: 1 h, 3 min, 1 h30)), :difficulty (if there is a precision of the difficulty, otherwise extrapolate one in base of the complexity of the recipe (format: Facile, Moyen, Difficile)), :servings (if there is the number of servings for this recipe otherwise extrapolate one, in base of the quantity of ingredients (format: 3 pers.)) :recipe_steps, Please render it in french without intro message. Here is the image"
                  },
                  {
                    "type": "image_url",
                    "image_url": {
                      "url": image_url
                    }
                  }
                ]
              }
            ]
          }
        )
        puts chatgpt_response

        # Extract the recipe content from GPT's response
        raw_content = chatgpt_response.dig("choices", 0, "message", "content")

        if raw_content.blank?
          return
        end
          puts raw_content
          # Remove Markdown code block delimiters (```ruby and ```)
          sanitized_content = raw_content.gsub(/```ruby/, '').gsub(/```/, '').strip
          puts sanitized_content


        # Populate recipe attributes
        parsed_data = eval(sanitized_content) # Use with caution! Only with trusted sources.
      # Populate recipe attributes
      @recipe.assign_attributes(
        recipe_name: parsed_data[:name],
        recipe_overview: parsed_data[:recipe_overview],
        recipe_category: parsed_data[:category],
        ingredients: parsed_data[:ingredients].join("\n"),
        preparation_time: parsed_data[:preparation_time],
        difficulty: parsed_data[:difficulty],
        servings: parsed_data[:servings],
        recipe_steps: parsed_data[:recipe_steps].join("\n")
      )

      rescue JSON::ParserError => e
        Rails.logger.error("JSON parsing error: #{e.message}")
        flash[:alert] = "Failed to process recipe data."
        render :new, status: :unprocessable_entity
        return
      rescue => e
        Rails.logger.error("Error during recipe creation: #{e.message}")
        flash[:alert] = "An unexpected error occurred. Please try again."
        render :new, status: :unprocessable_entity
        return
      end
    end
    # puts @recipe.ingredients

    @recipe.generate_dalle_image
    # @recipe = Recipe.create(recipe_params) => WARNING: will it break adding a recipe via form?
    @recipe.user = @user # associate a user recipe to the current user
    # TO DO => handle recipes for a current_user
    # @recipe = Recipe.create(recipe_params)
    @recipe.save!
    return @recipe
  end
end

# CreateRecipeFromImage.new(...).call
