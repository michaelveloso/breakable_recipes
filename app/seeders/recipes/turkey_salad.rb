class RecipeSeeder
  def self.turkey_salad
    exit if recipe("Turkey Salad")
    recipe = Recipe.new(name: "Turkey Salad", user: User.first)
    recipe.cooking_time = 15
    recipe.num_served_min = 6
    recipe.num_served_max = 8
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Toast almonds."
      }, {
        recipe: recipe,
        order: 2,
        body: "Mix all in bowl. Serve on tasty buns."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Almonds"),
        amount: "1/4 cup",
        preparation: "slivered",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Yogurt","Plain"),
        amount: "1/4 cup",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Mayonnaise"),
        amount: "3 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Ginger"),
        amount: "1 tsp",
        preparation: "ground",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Crushed Red Pepper"),
        amount: "1/8 tsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Celery"),
        amount: "3/4 cups",
        preparation: "thinly sliced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Onion", "Red"),
        amount: "1/4 cup",
        preparation: "chopped",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Cherries"),
        amount: "1/4 cup",
        preparation: "dried",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Raisins", "Golden"),
        amount: "1/4 cup",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Turkey"),
        amount: "8 oz.",
        preparation: "sliced/chopped",
        step: 2
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Sandwich")
  end
end
