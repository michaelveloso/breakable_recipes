require_relative 'recipes/corn_chowder_salad'
require_relative 'recipes/sesame_noodles_with_cucumber'
require_relative 'recipes/betsys_gumbo'
require_relative 'recipes/twice_baked_potatoes'

class RecipeSeeder
  def self.seed!
    corn_chowder_salad
    sesame_noodles_with_cucumber
    betsys_gumbo
    twice_baked_potatoes
  end

  def self.ingredient(name, subtype = nil)
    Ingredient.find_by!(name: name, subtype: subtype)
  end

  def self.category(name)
    Category.find_by!(name: name)
  end
end
