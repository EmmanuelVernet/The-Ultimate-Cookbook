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


  # def format_recipe_steps(steps_text)
  #   return "" if steps_text.nil? # Handle nil by returning an empty string
  #   steps_text.split("\n").map { |step| "<li>#{step.strip}</li>" }.join
  # end

  # def format_ingredients(ingredients_text)
  #   return "" if ingredients_text.nil?
  #   ingredients_text.split("\n").map { |ingredient| "<li>#{ingredient.strip}</li>" }.join
  # end


    def extract_text_from_image
      @recipe = Recipe.new
      @recipe.photo.attach(params[:photo])
      if @recipe.photo.attached?
        # Force public access for the image during upload
        Cloudinary::Uploader.upload(params[:photo].tempfile, public_id: @recipe.photo.filename.to_s, access_mode: 'public')

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
                      "text": " Analyze the image and respond with a Ruby hash containing the following keys: :name (recipe's title), :recipe_overview (If there is a short description of the recipe), :category(if there is a category starter, main course, otherwise extrapolate one), :ingredients (as an array of ingredients), :preparation_time (time to cook the recipe), :difficulty (if there is a precision of the difficulty, otherwise extrapolate one in base of the complexity of the recipe), :servings (if there is the number of servings for this recipe otherwise extrapolate one, in base of the quantity of ingredients) :recipe_steps, Please render it in french without intro message. Here is the image"
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
            flash[:alert] = "Failed to parse the recipe from the image."
            render :new, status: :unprocessable_entity
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
      else
        flash[:alert] = "Please upload a photo for the recipe."
        render :new, status: :unprocessable_entity
        return
      end
      puts @recipe.ingredients

      @recipe.set_photo
      # @recipe = Recipe.create(recipe_params) => WARNING: will it break adding a recipe via form?
      @recipe.user = current_user # associate a user recipe to the current user
      # TO DO => handle recipes for a current_user
      # @recipe = Recipe.create(recipe_params)
    end

    def generate_dalle_image
      GenerateImageForRecipe.new(self).call
    end
end
