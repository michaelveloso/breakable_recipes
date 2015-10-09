class RecipeSeeder
  def self.twice_baked_potatoes
    recipe = Recipe.new(name: "Twice-Baked Potatoes", user: User.first)
    recipe.cooking_time = 120
    recipe.num_served_min = 10
    recipe.num_served_max = 10
    recipe.complexity = 2
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Bake potatoes at 375 for 1 hour or until tender. While this is
          getting on, cook and crumble the bacon."
      }, {
        recipe: recipe,
        order: 2,
        body: "Cool potatoes for 10 minutes or until ready to handle. Cut each
          in half lenghtwise and scoop out pulp, leaving a 1/4-inch shell."
      }, {
        recipe: recipe,
        order: 3,
        body: "Mix potato pulp and all remaining ingredients until
          well-blended."
      }, {
        recipe: recipe,
        order: 4,
        body: "Spoon back into shells and bake at 375 degrees for another 20
          minutes or until heated."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Potatoes", "Russet"),
        amount: "5",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Buttermilk"),
        amount: "1 1/2 cups",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Blue Cheese"),
        amount: "1/2 cup",
        preparation: "crumbled",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Chives"),
        amount: "1/4 cup",
        preparation: "chopped",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Butter"),
        amount: "2 tbsp",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt"),
        amount: "1 1/4 tsp",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Pepper"),
        preparation: "1/4 tsp",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Bacon"),
        amount: "4 slices",
        preparation: "cooked and crumbled",
        step: 1
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Side Dish")
    recipe.categories << category("Fall")
  end
end
