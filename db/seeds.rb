# FollowersUser.destroy_all
# User.destroy_all

# create 4 user
# create FollowersUser

require "open-uri"

# Destroy existing records
RecipesIngredient.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
FollowersUser.destroy_all
User.destroy_all

# Create users
user1 = User.create!(email: "test1@test.com", password: "123456")
user2 = User.create!(email: "test2@test.com", password: "123456")
user3 = User.create!(email: "test3@test.com", password: "123456")
user4 = User.create!(email: "test4@test.com", password: "123456")

# Create ingredients
tomate = Ingredient.create(ingredient_name: "tomate")
courgette = Ingredient.create(ingredient_name: "courgette")
aubergine = Ingredient.create(ingredient_name: "aubergine")

# Create recipes
spaghetti = Recipe.create!(
  recipe_name: "Spaghetti Carbonara",
  recipe_overview: "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
  recipe_category: "Italian",
  preparation_time: "00:25:00",
  difficulty: "Medium",
  import_source: "Family Recipe",
  servings: 4,
  recipe_steps: "Cook pasta. Fry pancetta. Mix eggs and cheese. Combine all.",
  recipe_likes: 120,
  favorite: true,
  user: user1
)

file1 = URI.open("https://img.passeportsante.net/1200x675/2021-04-19/i101329-pates-a-la-carbonara.jpeg")
spaghetti.photo.attach(io: file1, filename: "spaghetti.jpg", content_type: "image/jpeg")
spaghetti.save!

chicken = Recipe.create!(
  recipe_name: "Chicken Tikka Masala",
  recipe_overview: "A rich and creamy tomato-based curry with marinated chicken.",
  recipe_category: "Indian",
  preparation_time: "01:00:00",
  difficulty: "Hard",
  import_source: "Cookbook",
  servings: 6,
  recipe_steps: "Marinate chicken. Grill. Cook curry base. Combine.",
  recipe_likes: 200,
  favorite: false,
  user: user3
)

file2 = URI.open("https://www.skinnytaste.com/wp-content/uploads/2011/06/Chicken-Tikka-Masala-15.jpg")
chicken.photo.attach(io: file2, filename: "chicken.jpg", content_type: "image/jpeg")
chicken.save!

toast = Recipe.create!(
  recipe_name: "Avocado Toast",
  recipe_overview: "Quick and healthy breakfast or snack.",
  recipe_category: "Breakfast",
  preparation_time: "00:10:00",
  difficulty: "Easy",
  import_source: "Internet",
  servings: 1,
  recipe_steps: "Toast bread. Mash avocado. Spread. Add toppings.",
  recipe_likes: 85,
  favorite: true,
  user: user2
)

file3 = URI.open("https://www.rootsandradishes.com/wp-content/uploads/2017/08/avocado-toast-with-everything-bagel-seasoning-feat.jpg")
toast.photo.attach(io: file3, filename: "toast.jpg", content_type: "image/jpeg")
toast.save!

beef = Recipe.create!(
  recipe_name: "Beef Stroganoff",
  recipe_overview: "A hearty dish with tender beef in a creamy sauce.",
  recipe_category: "Russian",
  preparation_time: "00:45:00",
  difficulty: "Medium",
  import_source: "Grandmother's Recipe",
  servings: 4,
  recipe_steps: "Sauté beef. Make creamy sauce. Combine and simmer.",
  recipe_likes: 150,
  favorite: true,
  user: user4
)

file4 = URI.open("https://www.fivehearthome.com/wp-content/uploads/2023/02/Crock-Pot-Beef-Stroganoff-Recipe-Slow-Cooker-Beef-Stroganoff-by-Five-Heart-Home_1200pxFeatured70.jpg")
beef.photo.attach(io: file4, filename: "beef.jpg", content_type: "image/jpeg")
beef.save!


# on rattache nos ingredients à toutes les recettes
Recipe.all.each do |recipe|
  RecipesIngredient.create(recipe: recipe, ingredient: tomate)
  RecipesIngredient.create(recipe: recipe, ingredient: courgette)
  RecipesIngredient.create(recipe: recipe, ingredient: aubergine)
end

puts "Finished! Created #{Recipe.count} recipes."
