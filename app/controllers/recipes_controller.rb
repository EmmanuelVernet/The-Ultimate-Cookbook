class RecipesController < ApplicationController
# Available routes => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!
  def index
    @user_recipes = Recipe.where(user_id: current_user.id)
    if params[:query].present?
      @recipes = Recipe.search_by_all_attributes(params[:query])
    elsif params.dig(:search, :keyword)
      @recipes = Recipe.search_by_all_attributes(params.dig(:search, :keyword))
    else
      @recipes = Recipe.all
    end
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      @recipe = user.recipes.find(params[:id])
    else
      @recipe = Recipe.find(params[:id])
    end
    # shared recipe
    @share = Share.new
    @formatted_steps = format_recipe_steps(@recipe.recipe_steps)
    @formatted_ingredients = format_ingredients(@recipe.ingredients)
    # Initialize a new Tag instance
    @tags_recipe = TagsRecipe.new
  end

  def format_recipe_steps(steps_text)
    return "" if steps_text.nil? # Handle nil by returning an empty string
    steps_text.split("\n").map { |step| "<li>#{step.strip}</li>" }.join
  end

  def format_ingredients(ingredients_text)
    return "" if ingredients_text.nil?
    ingredients_text.split("\n").map { |ingredient| "<li>#{ingredient.strip}</li>" }.join
  end


  def new
    @recipe = Recipe.new
  end

  def create
  #  rappel du job
    # puts"hello from controller recipe"
    # @recipe = Recipe.new
    # @recipe.photo.attach(params[:photo])
    # if @recipe.photo.attached?
    #   # Force public access for the image during upload
    #   Cloudinary::Uploader.upload(params[:photo].tempfile, public_id: @recipe.photo.filename.to_s, access_mode: 'public')

    #   # Retrieve the public URL of the uploaded image
    #   image_url = Cloudinary::Utils.cloudinary_url(@recipe.photo.filename.to_s, format: :jpg)
    #   puts image_url
    #   begin

    #     # Initialize OpenAI client
    #     client = OpenAI::Client.new
    #     # Send extracted text to OpenAI for recipe parsing
    #     chatgpt_response = client.chat(
    #       parameters: {
    #         model: "gpt-4o-mini",
    #         messages: [
    #           {
    #             "role": "user",
    #             "content": [
    #               {
    #                 "type": "text",
    #                 "text": " Analyze the image and respond with a Ruby hash containing the following keys: :name (recipe's title), :recipe_overview (If there is a short description of the recipe), :category(if there is a category starter, main course, otherwise extrapolate one), :ingredients (as an array of ingredients), :preparation_time (time to cook the recipe), :difficulty (if there is a precision of the difficulty, otherwise extrapolate one in base of the complexity of the recipe), :servings (if there is the number of servings for this recipe otherwise extrapolate one, in base of the quantity of ingredients) :recipe_steps, Please render it in french without intro message. Here is the image"
    #               },
    #               {
    #                 "type": "image_url",
    #                 "image_url": {
    #                   "url": image_url
    #                 }
    #               }
    #             ]
    #           }
    #         ]
    #       }
    #     )

    #     # Extract the recipe content from GPT's response
    #     raw_content = chatgpt_response.dig("choices", 0, "message", "content")
    #     if raw_content.blank?
    #       flash[:alert] = "Failed to parse the recipe from the image."
    #       render :new, status: :unprocessable_entity
    #       return
    #     end
    #       puts raw_content
    #       # Remove Markdown code block delimiters (```ruby and ```)
    #       sanitized_content = raw_content.gsub(/```ruby/, '').gsub(/```/, '').strip
    #       puts sanitized_content


    #     # Populate recipe attributes
    #     parsed_data = eval(sanitized_content) # Use with caution! Only with trusted sources.
    #   # Populate recipe attributes
    #   @recipe.assign_attributes(
    #     recipe_name: parsed_data[:name],
    #     recipe_overview: parsed_data[:recipe_overview],
    #     recipe_category: parsed_data[:category],
    #     ingredients: parsed_data[:ingredients].join("\n"),
    #     preparation_time: parsed_data[:preparation_time],
    #     difficulty: parsed_data[:difficulty],
    #     servings: parsed_data[:servings],
    #     recipe_steps: parsed_data[:recipe_steps].join("\n")
    #   )

    #   rescue JSON::ParserError => e
    #     Rails.logger.error("JSON parsing error: #{e.message}")
    #     flash[:alert] = "Failed to process recipe data."
    #     render :new, status: :unprocessable_entity
    #     return
    #   rescue => e
    #     Rails.logger.error("Error during recipe creation: #{e.message}")
    #     flash[:alert] = "An unexpected error occurred. Please try again."
    #     render :new, status: :unprocessable_entity
    #     return
    #   end
    # else
    #   flash[:alert] = "Please upload a photo for the recipe."
    #   render :new, status: :unprocessable_entity
    #   return
    # end
    # puts @recipe.ingredients

    # @recipe.set_photo

    @recipe = CreateRecipeFromImage.new(params.dig(:recipe, :photo), current_user).call
    # @recipe = CreateRecipeFromImage.new(:recipe, recipe_params[:photo], current_user).call
    redirect_to recipe_path(@recipe), notice: "Recette mise à jour!"
  end


  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "Recette mise à jour!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # find the Recipe item
    @recipe = Recipe.find(params[:id])
    # then destroy recipe
    if @recipe.destroy
      redirect_to cookbook_recipes_path, notice: "Recette supprimée"
    else
      redirect_to recipe_path(@recipe), alert: "Impossible de supprimer la recette"
    end
  end

  def cookbook
    @recipes = current_user.recipes # cookbook action for a loged in user
  end

  def add_to_cookbook
    # get the recipe by ID
    original_recipe = Recipe.find(params[:id])

    # store it in a variable and duplicate the recipe for the current user
    new_user_recipe = original_recipe.dup
    new_user_recipe.user_id = current_user.id
    if new_user_recipe.save
      redirect_to cookbook_recipes_path, notice: "Recette ajoutée!"
    else
      redirect_to recipe_path(original_recipe), alert: "Impossible d'ajouter la recette"
    end
  end


  def parse_recipe_text(text)
    sections = text.split("\n\n")
    # ingredients_section = sections.find { |section| section.downcase.include?("ingredient") || section.downcase.include?("method")  }
    steps_section = sections.find { |section| section.downcase.include?("step") || section.downcase.include?("method") }

  end

  # bg-logic
  def process_recipe
    recipe = Recipe.find(params[:id])

    # Enqueue the background job
    OcrImageProcessingJob.perform_later(recipe.id)

    render json: { message: 'Processing has started. You’ll be notified when it’s done.' }, status: :accepted
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings, :recipe_steps, :recipe_likes, :favorite, :photo, :ingredients, :calories)

  end

end
