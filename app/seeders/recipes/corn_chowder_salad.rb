class RecipeSeeder
  def self.corn_chowder_salad
    exit if recipe("Corn Chowder Salad")
    recipe = Recipe.new(name: "Corn Chowder Salad", user: User.first)
    recipe.cooking_time = 30
    recipe.num_served_min = 8
    recipe.num_served_max = 8
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Cook bacon: In a large frying pan, cook the bacon over moderately
          low heat, stirring a few times, until it is crisp, about 5 to 10
          minutes. Using a slotted spoon, transfer the bacon to paper towels and
          let drain."
      }, {
        recipe: recipe,
        order: 2,
        body: "Fry potatoes, peppers and corn: Pour off all but 3 tablespoons of
          the bacon fat in the skillet. Add the potatoes and cook over
          moderately high heat until they start to brown, about about 3 to 6
          minutes. Stir and cook for about 2 minutes longer, until almost
          tender; they’ll finish cooking with the other vegetables. Add the
          diced red peppers and cook, stirring occasionally, until the potatoes
          and peppers are tender, about 5 minutes. Add the corn kernels and
          cook, stirring, until heated through but still crisp, about 3
          minutes."
      }, {
        recipe: recipe,
        order: 3,
        body: "Assemble and serve: Transfer the vegetables to a large bowl and
          stir in the onion, cider vinegar and bacon. Season with red pepper and
          salt to taste. Serve warm, or at room temperature."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Bacon"),
        amount: "4 thick slices",
        preparation: "cut 1/2 inch thick",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Potatoes", "Yukon Gold"),
        amount: "1 pound",
        preparation: "peeled and 1/2-inch diced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Bell Peppers", "Red"),
        amount: "2",
        preparation: "1/2-inch diced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Corn"),
        amount: "6-8 ears",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Onion", "Red"),
        amount: "1 Medium",
        preparation: "thinly sliced",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Vinegar", "Cider"),
        amount: "1/4 cup",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt"),
        preparation: "to taste",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Crushed Red Pepper"),
        preparation: "to taste",
        step: 3
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Summer")
    recipe.categories << category("Side Dish")
  end
end
