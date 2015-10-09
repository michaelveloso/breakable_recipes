# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.production?
  CategorySeeder.seed!
  UserSeeder.seed!
  IngredientSeeder.seed!
  RecipeSeeder.seed!
end

if Rails.env.development?
  CategorySeeder.seed!
  UserSeeder.seed!
  IngredientSeeder.seed!
  RecipeSeeder.seed!
end
