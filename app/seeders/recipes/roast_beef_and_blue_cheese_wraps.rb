class RecipeSeeder
  def self.roast_beef_and_blue_cheese_wraps
    exit if recipe("Roast Beef and Blue Cheese Wraps")
    recipe = Recipe.new(
      name: "Roast Beef and Blue Cheese Wraps",
      user: User.first)
    recipe.cooking_time = 15
    recipe.num_served_min = 6
    recipe.num_served_max = 8
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Combine blue cheese, horseradish, mayonnaise, and 1/4 tsp
          pepper."
      }, {
        recipe: recipe,
        order: 2,
        body: "Combine 1 tbsp cheese mixture, vinegar, honey, and garlic in
          bowl. Add 1/4 tsp pepper, cabbage, celery, and basil."
      }, {
        recipe: recipe,
        order: 3,
        body: "Warm tortillas. Spread remaining cheese mixture over tortillas.
          Divide beef and cabbage mixture evenly among tortillas. Roll up."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Blue Cheese"),
        amount: "3/4 cup",
        preparation: "crumbled",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Horseradish"),
        amount: "2 tbsp",
        preparation: "prepared",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Mayonnaise"),
        amount: "2 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Black Pepper"),
        amount: "1/2 tsp",
        preparation: "divided",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Vinegar", "Sherry"),
        amount: "2 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Honey"),
        amount: "1 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "1 clove",
        preparation: "minced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Cabbage", "Red"),
        amount: "2 cups",
        preparation: "shredded",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Celery"),
        amount: "1/4 cup",
        preparation: "thinly sliced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Basil"),
        amount: "1/4 cup",
        preparation: "thinly sliced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Roast Beef"),
        amount: "8 oz",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Tortillas"),
        step: 3
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Sandwich")
  end
end
