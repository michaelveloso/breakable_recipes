class RecipeSeeder
  def self.guacamole
    exit if recipe("Guacamole")
    recipe = Recipe.new(name: "Guacamole", user: User.first)
    recipe.cooking_time = 15
    recipe.num_served_min = 4
    recipe.num_served_max = 6
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Mix. Mash. Eat."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Tomatoes", "Plum"),
        amount: "1",
        preparation: "diced",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Cilantro"),
        amount: "1/2 cup",
        preparation: "chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Shallots"),
        amount: "2",
        preparation: "finely chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Peppers", "Jalapeno"),
        amount: "1",
        preparation: "seeded and finely chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Avocados"),
        amount: "4",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Lime Juice"),
        amount: "3 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt"),
        preparation: "to taste",
        step: 1
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Side Dish")
    recipe.categories << category("Mexican")
    recipe.categories << category("Vegetarian")
  end
end
