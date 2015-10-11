class RecipeSeeder
  def self.edamame_and_white_bean_salad
    exit if recipe("Edamame and White Bean Salad")
    recipe = Recipe.new(name: "Edamame and White Bean Salad", user: User.first)
    recipe.cooking_time = 15
    recipe.num_served_min = 3
    recipe.num_served_max = 4
    recipe.complexity = 2
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Bring pot of salted water to boil. Cook edamame for 3 minutes.
          Drain and rinse with cold water."
      }, {
        recipe: recipe,
        order: 2,
        body: "In a large skillet over MEDIUM-HIGH heat, heat the olive oil
          and cook the prosciutto, stirring often, for 2 minutes or until
          crispy."
      }, {
        recipe: recipe,
        order: 3,
        body: "Add garlic and red pepper and cook 1 minute."
      }, {
        recipe: recipe,
        order: 4,
        body: "Add edamame and white beans. Cook, stirring gently, for 1
          minute or until just warmed through."
      }, {
        recipe: recipe,
        order: 5,
        body: "Stir in parsley, basil, lemon, salt, and pepper. Sprinkle with
          olive oil."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Edamame"),
        amount: "2 cups",
        preparation: "frozen",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Oil", "Olive"),
        amount: "2 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Prosciutto"),
        amount: "2 oz",
        preparation: "coarsely chopped",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "2 cloves",
        preparation: "chopped",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Crushed Red Pepper"),
        amount: "1/4 tsp",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Beans", "Cannellini"),
        amount: "15 oz",
        preparation: "drained and rinsed",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Parsley"),
        amount: "2 tbsp",
        preparation: "chopped",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Basil"),
        amount: "2 tbsp",
        preparation: "chopped",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Lemon Juice"),
        amount: "2 tbsp",
        step: 5
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Side Dish")
    recipe.categories << category("Fall")
    recipe.categories << category("Winter")
  end
end
