class RecipeSuggestor
  def self.get_recipes(ingredient_ids, user)
    ingredients = get_ingredients(ingredient_ids)
    gather_recipes(ingredients, user)
  end

  def self.get_ingredients(ingredient_ids)
    ingredients = []
    ingredient_ids.each do |id|
      ingredients << Ingredient.find(id)
    end
    ingredients
  end

  def self.gather_recipes(ingredients, user)
    recipes = count_recipes(ingredients, user)
    sort_recipes(recipes)
  end

  def self.count_recipes(ingredients, user)
    recipes = {}
    ingredients.each do |ingredient|
      ingredient.recipes.each do |recipe|
        if recipe.user = user
          if recipes[recipe]
            recipes[recipe] += 1
          else
            recipes[recipe] = 1
          end
        end
      end
    end
    recipes
  end

  def self.sort_recipes(recipes)
    sorted_recipes_raw = recipes.sort_by { |_recipe, count| -count }
    sorted_recipes = []
    sorted_recipes_raw.each do |recipe_array|
      sorted_recipes << recipe_array[0]
    end
    sorted_recipes
  end
end
