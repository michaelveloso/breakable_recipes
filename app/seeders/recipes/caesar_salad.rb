class RecipeSeeder
  def self.caesar_salad
    exit if recipe("Caesar Salad")
    recipe = Recipe.new(name: "Caesar Salad", user: User.first)
    recipe.cooking_time = 15
    recipe.num_served_min = 4
    recipe.num_served_max = 6
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Mix dressing."
      }, { recipe: recipe,
        order: 2,
        body: "Add dressing to lettuce and toss. Add
          cheese and toss. Add croutons and toss. Serve."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "2 cloves",
        preparation: "crushed",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Oil", "Olive"),
        amount: "5 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Mustard", "Dijon"),
        amount: "1 tsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Egg Yolks"),
        amount: "2",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Lemon Juice"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Vinegar", "Red Wine"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Worcestershire Sauce"),
        amount: "1 tsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Anchovy Paste"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Lettuce", "Romaine"),
        amount: "2 Large Heads",
        preparation: "chopped",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Cheese", "Parmesan"),
        amount: "1/2 cup",
        preparation: "grated",
        step: 2
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Salad")
    recipe.categories << category("Italian")
    recipe.categories << category("Side Dish")
  end
end
