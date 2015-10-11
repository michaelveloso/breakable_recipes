class RecipeSeeder
  def self.black_bean_and_corn_salsa
    exit if recipe("Black Bean and Corn Salsa")
    recipe = Recipe.new(name: "Black Bean and Corn Salsa", user: User.first)
    recipe.cooking_time = 15
    recipe.num_served_min = 4
    recipe.num_served_max = 8
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Chop. Mix. Eat."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Beans","Black"),
        amount: "52 oz.",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Corn"),
        amount: "45 oz.",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Lime Juice"),
        amount: "3 limes' worth",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Bell Peppers", "Red"),
        amount: "1",
        preparation: "chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Onions"),
        amount: "1 medium",
        preparation: "chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "3 cloves",
        preparation: "crushed",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Hot Sauce"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Cilantro"),
        amount: "1/2 cup",
        preparation: "chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Goya Sazon"),
        amount: "1 package",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Vinegar", "Red Wine"),
        amount: "1 tbsp",
        step: 1
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Mexican")
    recipe.categories << category("Side Dish")
    recipe.categories << category("Snack")
  end
end
