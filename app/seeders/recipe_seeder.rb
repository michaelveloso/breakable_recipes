require_relative 'recipes/corn_chowder_salad'
require_relative 'recipes/sesame_noodles_with_cucumber'
require_relative 'recipes/betsys_gumbo'
require_relative 'recipes/twice_baked_potatoes'
require_relative 'recipes/caesar_salad'
require_relative 'recipes/guacamole'
require_relative 'recipes/edamame_and_white_bean_salad'
require_relative 'recipes/black_bean_and_corn_salsa'
require_relative 'recipes/german_style_braised_red_cabbage'
require_relative 'recipes/corn_chowder'
require_relative 'recipes/turkey_salad'
require_relative 'recipes/roast_beef_and_blue_cheese_wraps'
require_relative 'recipes/pasta_amatriciana'

class RecipeSeeder
  def self.seed!
    roast_beef_and_blue_cheese_wraps
    turkey_salad
    corn_chowder
    caesar_salad
    corn_chowder_salad
    sesame_noodles_with_cucumber
    betsys_gumbo
    twice_baked_potatoes
    guacamole
    edamame_and_white_bean_salad
    black_bean_and_corn_salsa
    german_style_braised_red_cabbage
    pasta_amatriciana
  end

  def self.ingredient(name, subtype = nil)
    ingredient_found = Ingredient.find_by(name: name, subtype: subtype)
    if ingredient_found
      ingredient_found
    else
      puts "#{name}, #{subtype} not found"
    end
  end

  def self.category(name)
    Category.find_by!(name: name)
  end

  def self.recipe(name)
    Recipe.find_by(name: name)
  end
end
