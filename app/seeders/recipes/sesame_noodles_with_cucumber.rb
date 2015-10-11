class RecipeSeeder
  def self.sesame_noodles_with_cucumber
    exit if recipe("Sesame Noodles with Cucumber")
    recipe = Recipe.new(name: "Sesame Noodles with Cucumber", user: User.first)
    recipe.cooking_time = 30
    recipe.num_served_min = 4
    recipe.num_served_max = 8
    recipe.complexity = 1
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Cook noodles according to package directions and rinse with cold
          water to cool. Drain well. Drizzle with a tiny splash of toasted
          sesame oil to keep them from sticking until dressed."
      }, {
        recipe: recipe,
        order: 2,
        body: "Meanwhile, whisk sesame paste and peanut butter in the bottom of
          a small bowl, then whisk in soy sauce, rice vinegar, remaining 2
          tablespoons sesame oil, sugar, ginger, garlic and chile-garlic paste
          to taste until smooth. Adjust flavors to taste. It might seem a bit
          salty from the bowl, but should be just right when tossed with
          noodles."
      }, {
        recipe: recipe,
        order: 3,
        body: "Toss sauce with cold noodles."
      }, {
        recipe: recipe,
        order: 4,
        body: "Place a medium-sized knot of dressed noodles in each bowl,
          followed by a pile of cucumber. Garnish generously with peanuts and
          herbs. Serve with extra chile-garlic paste on the side."
      }]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Rice Noodles"),
        amount: "3/4 pound",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Oil", "Sesame"),
        amount: "2 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Sesame Paste"),
        amount: "2 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Peanut Butter", "Smooth"),
        amount: "1 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Soy Sauce"),
        amount: "3 1/2 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Vinegar", "Rice"),
        amount: "2 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Sugar", "Brown"),
        amount: "1 tbsp",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Ginger"),
        amount: "1 tbsp",
        preparation: "grated",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic"),
        amount: "2 tsp",
        preparation: "minced",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Chili-garlic Paste"),
        preparation: "to taste",
        step: 2
      }, {
        recipe: recipe,
        ingredient: ingredient("Cucumber"),
        amount: "1/2 pound",
        preparation: "very thinly sliced",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Peanuts", "Roasted Salted"),
        amount: "1/2 cup",
        preparation: "roughly chopped",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Mint"),
        amount: "handful",
        preparation: "chopped",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Cilantro"),
        amount: "handful",
        preparation: "chopped",
        step: 4
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Asian")
    recipe.categories << category("Vegetarian")
  end
end
