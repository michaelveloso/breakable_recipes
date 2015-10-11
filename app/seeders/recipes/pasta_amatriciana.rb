class RecipeSeeder
  def self.pasta_amatriciana
    exit if recipe("Pasta Amatriciana")
    recipe = Recipe.new(name: "Pasta Amatriciana", user: User.first)
    recipe.cooking_time = 90
    recipe.num_served_min = 6
    recipe.num_served_max = 8
    recipe.complexity = 2
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Heat oil in saucepan over MEDIUM-HIGH heat. Add onions and
          saute for 10 minutes."
      }, {
        recipe: recipe,
        order: 2,
        body: "Stir in ham and garlic, saute 5 minutes."
      }, {
        recipe: recipe,
        order: 4,
        body: "Stir in tomatoes, sugar, wine, and rosemary. Season with salt &
          pepper. Simmer uncovered for 45 minutes, stirring occasionally."
      }, {
        recipe: recipe,
        order: 3,
        body: "Start cooking pasta."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Fettuccine"),
        amount: "2 lb",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Oil", "Olive"),
        amount: "1/4 cup",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Onions"),
        amount: "4",
        preparation: "coarsely chopped",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Ham"),
        amount: "8 oz",
        preparation: "chopped",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "4 cloves",
        preparation: "crushed",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Tomatoes"),
        amount: "70 oz.",
        preparation: "diced",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Sugar"),
        amount: "2 tsp",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Red Wine"),
        amount: "3/4 cups",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt"),
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Pepper"),
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Rosemary"),
        amount: "2 sprigs",
        step: 4
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Pasta")
    recipe.categories << category("Italian")
  end
end
