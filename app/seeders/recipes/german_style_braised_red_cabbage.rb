class RecipeSeeder
  def self.german_style_braised_red_cabbage
    exit if recipe("German_style Braised Red Cabbage")
    recipe = Recipe.new(name: "German-Style Braised Red Cabbage", user: User.first)
    recipe.cooking_time = 120
    recipe.num_served_min = 4
    recipe.num_served_max = 8
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "In heavy pot with lid, cook bacon over MEDIUM-LOW until fat is
          rendered. Add caraway seeds, increase heat to MEDIUM and cook,
          stirring, until seeds are fragrant, about 2 minutes."
      }, {
        recipe: recipe,
        order: 2,
        body: "Add onion and cook, stirring frequently, until onions are
          translucent, about 7-9 minutes."
      }, {
        recipe: recipe,
        order: 3,
        body: "Add other ingredients and stir. Bring to simmer, cover, and
          cook about 90 minutes."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Bacon"),
        amount: "4 slices",
        preparation: "roughyl chopped",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Caraway Seeds"),
        amount: "1/2 tsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Onions"),
        amount: "1 Small",
        preparation: "finely diced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Apples"),
        amount: "2",
        preparation: "peeled, cored, and medium diced",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Molasses"),
        amount: "2 tbsp",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("White Wine"),
        amount: "1/4 cup",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Vinegar", "Red Wine"),
        amount: "1/4 cup",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt & Pepper"),
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Side Dish")
    recipe.categories << category("Winter")
    recipe.categories << category("Fall")
  end
end
