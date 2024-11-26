# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_26_142523) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string "ingredient_name"
    t.string "ingredient_category"
    t.integer "calorie"
    t.integer "protein"
    t.integer "glucide"
    t.integer "lipide"
    t.integer "fibre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipe_name"
    t.text "recipe_overview"
    t.string "recipe_category"
    t.time "preparation_time"
    t.string "difficulty"
    t.string "import_source"
    t.integer "servings"
    t.text "recipe_steps"
    t.integer "recipe_likes"
    t.boolean "favorite"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "recipes_ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipes_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipes_ingredients_on_recipe_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "user_id", null: false
    t.text "comment"
    t.integer "star"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_reviews_on_recipe_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.text "message"
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_shares_on_receiver_id"
    t.index ["recipe_id"], name: "index_shares_on_recipe_id"
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_recipe", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_tags_recipe_on_recipe_id"
    t.index ["tag_id"], name: "index_tags_recipe_on_tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.text "profile_description"
    t.string "allergies", default: [], array: true
    t.time "available_time"
    t.integer "family_size"
    t.integer "budget"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "recipes", "users"
  add_foreign_key "recipes_ingredients", "ingredients"
  add_foreign_key "recipes_ingredients", "recipes"
  add_foreign_key "reviews", "recipes"
  add_foreign_key "reviews", "users"
  add_foreign_key "shares", "recipes"
  add_foreign_key "shares", "users"
  add_foreign_key "shares", "users", column: "receiver_id"
  add_foreign_key "tags_recipe", "recipes"
  add_foreign_key "tags_recipe", "tags"
end
