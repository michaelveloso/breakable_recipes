class RecipeSeeder
  def self.corn_chowder
    exit if recipe("Corn Chowder")
    recipe = Recipe.new(name: "Corn Chowder", user: User.first)
    recipe.cooking_time = 120
    recipe.num_served_min = 6
    recipe.num_served_max = 8
    recipe.complexity = 2
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Preheat oven to 350F."
      }, {
        recipe: recipe,
        order: 2,
        body: "Place onions & garlic in shallow roasting pan. Add 3 cups of
          chicken stock. Sprinkle with thyme, pepper, and salt. Dot with
          butter."
      }, {
        recipe: recipe,
        order: 3,
        body: "Cover pan with aluminum foil. Bake for 90 minutes. Stir every
          30 minutes."
      }, {
        recipe: recipe,
        order: 4,
        body: "Remove pan. Pour into pot and puree with hand mixer, adding
          heavy cream and remaining chicken stock."
      }, {
        recipe: recipe,
        order: 5,
        body: "Adjust seasonings and add corn. Heat slowly through, without
          allowing to boil. Sprinkle with parsley and serve."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Onions"),
        amount: "6 Large",
        preparation: "cut into thick slices",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "2 heads",
        preparation: "cloves isolated",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Chicken Stock"),
        amount: "5 cups",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Thyme"),
        amount: "1 1/2 tsp",
        preparation: "dried",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Black Pepper"),
        amount: "1 tsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt", "Kosher"),
        amount: "1 tsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Butter", "Unsalted"),
        amount: "4 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Heavy Cream"),
        amount: "2 cups",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Parsley"),
        amount: "2 tbsp",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Corn"),
        amount: "2 cans",
        step: 5
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Soup")
    recipe.categories << category("Winter")
    recipe.categories << category("Fall")
  end
end
