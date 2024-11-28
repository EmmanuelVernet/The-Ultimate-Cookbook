class RecipesController < ApplicationController
# Available routes => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!
  def index
    @user_recipes = Recipe.where(user_id: current_user.id)
    @recipes = Recipe.all
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      @recipe = user.recipes.find(params[:id])
    else
      @recipe = Recipe.find(params[:id])
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    puts"hello from controller recipe"
    @recipe = Recipe.new
    @recipe.photo.attach(params[:photo])
    if @recipe.photo.attached?
      # Force public access for the image during upload
      Cloudinary::Uploader.upload(params[:photo].tempfile, public_id: @recipe.photo.filename.to_s, access_mode: 'public')

      # Retrieve the public URL of the uploaded image
      image_url = Cloudinary::Utils.cloudinary_url(@recipe.photo.filename.to_s, format: :jpg)
      puts image_url
      begin
        # # Get the uploaded photo path



        # Initialize OpenAI client
        client = OpenAI::Client.new

        # # Send the image to OpenAI for OCR
        # response = client.images.process(
        #   parameters: {
        #     image: {
        #       file: File.open(image),
        #       purpose: "ocr"
        #     }
        #   }
        # )

        # puts "whhyyyyyyyy"

        # # Extract text from the OCR response
        # extracted_text = response.dig("data", "text")
        # if extracted_text.blank?
        #   flash[:alert] = "Failed to extract text from the uploaded image."
        #   render :new, status: :unprocessable_entity
        #   return
        # end

        puts "test2"

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
                    "text": " Analyze the image and respond with a Ruby hash containing the following keys: :name (recipe's title), :recipe_overview (If there is a short description of the recipe), :category(if there is a category starter, main course, otherwise extrapolate one), :ingredients(as an array of ingredients) :preparation_time(if there is the cooking time otherwise extrapolate ), :difficulty (if there is a precision of the difficulty, otherwise extrapolate one in base of the complexity of the recipe), :servings (if there is the number of servings for this recipe otherwise extrapolate one, in base of the quantity of ingredients) :recipe_steps (the step by step of the recipe as a array for each step), Please render it in french without intro message. Here is the image"
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
        # ingredients: parsed_data[:ingredients].join("\n"),
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

    @recipe.user = current_user
    # TO DO => handle recipes for a current_user
    # @recipe = Recipe.create(recipe_params)

    if @recipe.save!
      redirect_to recipe_path(@recipe), notice: "Recipe successfully created!"



    else
      render :new, status: :unprocessable_entity
    end

    # TO DO => implement separate logic for OCR analysis with OpenAI
  end


  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "Recipe updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # find the Recipe item
    @recipe = Recipe.find(params[:id])
    # then destroy recipe
    if @recipe.destroy
      redirect_to recipes_path, notice: "Recipe deleted"
    else
      redirect_to recipe_path(@recipe), alert: "Can't delete recipe"
    end
  end

  def cookbook
    @recipes = current_user.recipes # cookbook action for a loged in user
  end

  def add_to_coobook
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

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :recipe_overview, :recipe_category, :preparation_time, :difficulty, :import_source, :servings, :recipe_steps, :recipe_likes, :favorite, :photo)

  end

  def parse_recipe_text(text)
    # Simplified parsing logic: split text by sections
    sections = text.split("\n\n")
    ingredients = sections.find { |section| section.downcase.include?("ingredient") }
    steps = sections.find { |section| section.downcase.include?("step") || section.downcase.include?("method") }
    [ingredients || "", steps || ""]
  end
end
