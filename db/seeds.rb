# FollowersUser.destroy_all
# User.destroy_all

# create 4 user
# create FollowersUser

require "nokogiri"
require "open-uri"

# Destroy existing records
# RecipesIngredient.destroy_all
# Ingredient.destroy_all
Share.destroy_all
Recipe.destroy_all
FollowersUser.destroy_all
User.destroy_all
Tag.destroy_all

# # Create users
user1 = User.create!(email: "test1@test.com", password: "123456", user_name: "Ahmed Mecherouk")
user2 = User.create!(email: "test2@test.com", password: "123456", user_name: "Délia Knoepfli")
user3 = User.create!(email: "test3@test.com", password: "123456", user_name: "Pierre Songy")
user4 = User.create!(email: "test4@test.com", password: "123456", user_name: "Emmanuel Vernet")
user5 = User.create!(email: "test5@test.com", password: "123456", user_name: "Cyril Lignac")

# # User picture cloudinary => upload, parse uri, rattach to user, save // OU // direct dans les assets

# # Seed tags
Tag.create!(name: "Healthy")
Tag.create!(name: "Vegan")
Tag.create!(name: "Light")
Tag.create!(name: "Gourmand")
Tag.create!(name: "Rapide")
Tag.create!(name: "Vitaminé")
Tag.create!(name: "Légumes")
Tag.create!(name: "Italien")
Tag.create!(name: "Dessert")
Tag.create!(name: "Copieux")
Tag.create!(name: "Français")

# # Create ingredients
# tomate = Ingredient.create(ingredient_name: "tomate")
# courgette = Ingredient.create(ingredient_name: "courgette")
# aubergine = Ingredient.create(ingredient_name: "aubergine")

# # Create recipes
spaghetti = Recipe.create!(
  recipe_name: "Spaghetti Carbo",
  recipe_overview: "Un plat de pâtes italien classique à base d'œufs, de fromage, de pancetta et de poivre.",
  recipe_category: "Italien",
  preparation_time: "25 min.",
  difficulty: "Moyen",
  import_source: "Recette de famille",
  servings: 4,
  recipe_steps: "1 - Cuire les pâtes. 2 - Faire revenir la pancetta. 3 - Mélanger les œufs et le fromage. 4 - Mélanger le tout.",
  recipe_likes: 120,
  favorite: true,
  user: user1
)

file1 = URI.open("https://img.passeportsante.net/1200x675/2021-04-19/i101329-pates-a-la-carbonara.jpeg")
spaghetti.photo.attach(io: file1, filename: "spaghetti.jpg", content_type: "image/jpeg")
spaghetti.save!

chicken = Recipe.create!(
  recipe_name: "Chicken Tikka Masala",
  recipe_overview: "Un curry riche et crémeux à base de tomates avec du poulet mariné.",
  recipe_category: "Indien",
  preparation_time: "60 min.",
  difficulty: "Difficile",
  import_source: "Cookbook",
  servings: 6,
  recipe_steps: "1 - Mariner le poulet. 2 - Griller. 3 - Cuire la base de curry. 4 - Mélanger.",
  recipe_likes: 200,
  favorite: false,
  user: user3
)

file2 = URI.open("https://www.skinnytaste.com/wp-content/uploads/2011/06/Chicken-Tikka-Masala-15.jpg")
chicken.photo.attach(io: file2, filename: "chicken.jpg", content_type: "image/jpeg")
chicken.save!

toast = Recipe.create!(
  recipe_name: "Toast à l'avocat",
  recipe_overview: "Petit déjeuner ou en-cas rapide et sain.",
  recipe_category: "Petit déjeuner",
  preparation_time: "10 min.",
  difficulty: "Facile",
  import_source: "Internet",
  servings: 1,
  recipe_steps: "1 - Faire griller le pain. 2 - Ecraser l'avocat. 3 - Tartiner. 4 - Ajouter des garnitures.",
  recipe_likes: 85,
  favorite: true,
  user: user2
)

file3 = URI.open("https://www.rootsandradishes.com/wp-content/uploads/2017/08/avocado-toast-with-everything-bagel-seasoning-feat.jpg")
toast.photo.attach(io: file3, filename: "toast.jpg", content_type: "image/jpeg")
toast.save!

beef = Recipe.create!(
  recipe_name: "Boeuf Stroganoff",
  recipe_overview: "Un plat copieux avec du bœuf tendre dans une sauce crémeuse.",
  recipe_category: "Russe",
  preparation_time: "45 min.",
  difficulty: "Moyen",
  import_source: "Recette de grand-mère",
  servings: 4,
  recipe_steps: "1 - Faire sauter le bœuf. 2 - Préparer une sauce crémeuse. 3 - Mélanger et laisser mijoter.",
  recipe_likes: 150,
  favorite: true,
  user: user4
)

file4 = URI.open("https://www.fivehearthome.com/wp-content/uploads/2023/02/Crock-Pot-Beef-Stroganoff-Recipe-Slow-Cooker-Beef-Stroganoff-by-Five-Heart-Home_1200pxFeatured70.jpg")
beef.photo.attach(io: file4, filename: "beef.jpg", content_type: "image/jpeg")
beef.save!


# # Recettes Pierre pour test grid


test1 = Recipe.create!(
  recipe_name: "Test 1",
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
test1.photo.attach(io: file1, filename: "spaghetti.jpg", content_type: "image/jpeg")
test1.save!

test2 = Recipe.create!(
  recipe_name: "Test 2",
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
test2.photo.attach(io: file1, filename: "spaghetti.jpg", content_type: "image/jpeg")
test2.save!

test3 = Recipe.create!(
  recipe_name: "Test 3",
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
test3.photo.attach(io: file1, filename: "spaghetti.jpg", content_type: "image/jpeg")
test3.save!

test4 = Recipe.create!(
  recipe_name: "Pancetta",
  recipe_overview: "Un plat de pâtes italien classique à base d'œufs, de fromage, de pancetta et de poivre.",
  recipe_category: "Italien",
  preparation_time: "25 min.",
  difficulty: "Moyen",
  import_source: "Recette familiale",
  servings: 4,
  recipe_steps: "1 - Cuire les pâtes. 2 - Faire revenir la pancetta. 3 - Mélanger les œufs et le fromage. 3 - Mélanger le tout.",
  recipe_likes: 120,
  favorite: true,
  user: user1
)

file1 = URI.open("https://img.passeportsante.net/1200x675/2021-04-19/i101329-pates-a-la-carbonara.jpeg")
test4.photo.attach(io: file1, filename: "spaghetti.jpg", content_type: "image/jpeg")
test4.save!



# # on rattache nos ingredients à toutes les recettes
# Recipe.all.each do |recipe|
#   RecipesIngredient.create(recipe: recipe, ingredient: tomate)
#   RecipesIngredient.create(recipe: recipe, ingredient: courgette)
#   RecipesIngredient.create(recipe: recipe, ingredient: aubergine)
# end




url = "http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx"
user_serialized = URI.parse(url).read

recipe = Nokogiri::HTML.parse(user_serialized)


array_ingredients = []
recipe.search(".mrtn-recette_ingredients .mrtn-recette_ingredients-items .card-ingredient .card-ingredient-content .card-ingredient-title .ingredient-name").text.strip.split("\n").each do |doc|
  array_ingredients << doc.strip
end


array_steps = []
recipe.search(".recipe-step-list .recipe-step-list__container p").each do |doc|
  array_steps << doc.text.strip
end

timing = recipe.search(".recipe-primary .recipe-primary__item").first.text.strip
minutes = timing.split(" ").first

burger = Recipe.create!(
  recipe_name: recipe.search(".main-title h1").text.strip,
  recipe_overview: "Le burger d'avocat est une variante innovante et saine du burger traditionnel, où les pains sont remplacés par des moitiés d'avocat",
  recipe_category: "burger",
  preparation_time: "#{minutes} min.",
  difficulty: recipe.search(".recipe-primary .recipe-primary__item")[1].text.strip,
  import_source: "marmiton",
  servings: recipe.search(".mrtn-recette_ingredients-counter")[0].attributes["data-servingsnb"].value.to_i,
  recipe_steps: array_steps.join(" "),
  recipe_likes: 85,
  favorite: true,
  user: user4
  )

file6 = URI.open("https://assets.afcdn.com/recipe/20160914/63596_w314h314c1cx2000cy3000.webp")
burger.photo.attach(io: file6, filename: "burger.jpg", content_type: "image/jpeg")
burger.save!

# array_ingredients.each do |ingredient_name|
#   ingredient = Ingredient.find_or_create_by!(ingredient_name: ingredient_name)
#   RecipesIngredient.create!(recipe: burger, ingredient: ingredient)
# end


url2 = "https://www.marmiton.org/recettes/recette_gigot-de-sept-heures_12368.aspx"
user_serialized = URI.parse(url2).read

recipe1 = Nokogiri::HTML.parse(user_serialized)

array_ingredients1 = []
recipe1.search(".mrtn-recette_ingredients .mrtn-recette_ingredients-items .card-ingredient .card-ingredient-content .card-ingredient-title .ingredient-name").text.strip.split("\n").each do |doc|
  array_ingredients1 << doc.strip
end

array_steps1 = []
recipe1.search(".recipe-step-list .recipe-step-list__container p").each do |doc|
  array_steps1 << doc.text.strip
end

timing1 = recipe1.search(".recipe-primary .recipe-primary__item").first.text.strip
minutes1 = timing1.split(" ").first

gigot = Recipe.create!(
  recipe_name: recipe1.search(".main-title h1").text.strip,
  recipe_overview: "Le gigot de 7 heures est une recette traditionnelle française, souvent considérée comme incontournable pour des occasions spéciales comme Pâques. Ce plat tire son nom de sa cuisson lente, permettant à l'agneau de devenir si tendre qu'il peut être servi à la cuillère.",
  recipe_category: "viande",
  preparation_time: "#{minutes1} min.",
  difficulty: recipe1.search(".recipe-primary .recipe-primary__item")[1].text.strip,
  import_source: "marmiton",
  servings: recipe1.search(".mrtn-recette_ingredients-counter")[0].attributes["data-servingsnb"].value.to_i,
  recipe_steps: array_steps1.join(" "),
  recipe_likes: 120,
  favorite: false,
  user: user3
  )

file7 = URI.open("https://assets.afcdn.com/recipe/20160404/24205_w314h314c1cx1500cy1009.webp")
gigot.photo.attach(io: file7, filename: "gigot.jpg", content_type: "image/jpeg")
gigot.save!

# array_ingredients1.each do |ingredient_name|
#   ingredient = Ingredient.find_or_create_by!(ingredient_name: ingredient_name)
#   RecipesIngredient.create!(recipe: gigot, ingredient: ingredient)
# end


puts "Finished! Created #{Recipe.count} recipes."
