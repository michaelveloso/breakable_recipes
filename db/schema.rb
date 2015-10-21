# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151021135959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carted_recipes", force: :cascade do |t|
    t.integer "recipe_id",      null: false
    t.integer "recipe_cart_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "ingredient_lists", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.string  "amount"
    t.integer "recipe_id",     null: false
    t.string  "preparation"
    t.integer "step"
  end

  add_index "ingredient_lists", ["recipe_id", "ingredient_id"], name: "index_ingredient_lists_on_recipe_id_and_ingredient_id", unique: true, using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string "name",    null: false
    t.string "subtype"
  end

  add_index "ingredients", ["name", "subtype"], name: "index_ingredients_on_name_and_subtype", unique: true, using: :btree

  create_table "recipe_carts", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.boolean  "ordered",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_categories", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "recipe_id",   null: false
  end

  add_index "recipe_categories", ["recipe_id", "category_id"], name: "index_recipe_categories_on_recipe_id_and_category_id", unique: true, using: :btree

  create_table "recipe_steps", force: :cascade do |t|
    t.string  "body",      null: false
    t.integer "order",     null: false
    t.integer "recipe_id", null: false
  end

  add_index "recipe_steps", ["recipe_id", "order"], name: "index_recipe_steps_on_recipe_id_and_order", unique: true, using: :btree

  create_table "recipes", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.string   "name",                           null: false
    t.integer  "cooking_time"
    t.integer  "num_served_min"
    t.integer  "num_served_max"
    t.integer  "complexity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shared",         default: false
  end

  add_index "recipes", ["name", "user_id"], name: "index_recipes_on_name_and_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "first_name",                                null: false
    t.string   "last_name",                                 null: false
    t.string   "username",                                  null: false
    t.string   "role",                   default: "member", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
