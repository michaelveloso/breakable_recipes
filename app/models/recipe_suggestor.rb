class RecipeSuggestor

  def self.get_recipes(ingredient_ids)
    ingredients = get_ingredients(ingredient_ids)
    gather_recipes(ingredients)
  end

  private

  def self.get_ingredients(ingredient_ids)
    ingredients = []
    ingredient_ids.each do |id|
      ingredients << Ingredient.find(id)
    end
    ingredients
  end

  def self.gather_recipes(ingredients)
    recipes = count_recipes(ingredients)
    recipes = sort_recipes(recipes)
  end

  def self.count_recipes(ingredients)
    recipes = {}
    ingredients.each do |ingredient|
      ingredient.recipes.each do |recipe|
        if recipes[recipe]
          recipes[recipe] += 1
        else
          recipes[recipe] = 1
        end
      end
    end
  end

  def self.sort_recipes(recipes)
    sorted_recipes_raw = recipes.sort_by { |recipe, count| -count }
    sorted_recipes = []
    sorted_recipes_raw.each do |recipe_array|
      sorted_recipes << recipe_array[0]
    end
    sorted_recipes
  end
end
