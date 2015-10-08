class RecipeSeeder
  def self.seed!
    corn_chowder_salad
    sesame_noodles_with_cucumber
  end

  def self.ingredient(name, subtype = nil)
    Ingredient.find_by(name: name, subtype: subtype)
  end

  def self.category(name)
    Category.find_by(name: name)
  end

  def self.corn_chowder_salad
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
    recipe.categories << category("Side Dish")
  end

  def self.sesame_noodles_with_cucumber
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
