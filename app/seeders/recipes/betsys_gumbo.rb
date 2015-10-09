class RecipeSeeder
  def self.betsys_gumbo
    recipe = Recipe.new(name: "Betsy's Gumbo", user: User.first)
    recipe.cooking_time = 240
    recipe.num_served_min = 12
    recipe.num_served_max = 16
    recipe.complexity = 2
    recipe.save!

    recipe_step_hashes = [
      { recipe: recipe,
        order: 1,
        body: "Mix file powder."
      }, {
        recipe: recipe,
        order: 2,
        body: "In a large pot, heat 1 tbsp oil over MEDIUM-HIGH head. Cook
          sausage until well-browned, about 8 minutes. Remove, drain, and set
          aside."
      }, {
        recipe: recipe,
        order: 3,
        body: "Coat chicken in file powder and add in batches to fat in pan.
          Cook over MEDIUM-HIGH until well-browned, about 5-6 minutes. Remove."
      }, {
        recipe: recipe,
        order: 4,
        body: "Combine 1/2 cup oil and flour over MEDIUM heat. Make roux until
          chocolate-brown, 20-25 minutes."
      }, {
        recipe: recipe,
        order: 5,
        body: "Add onions, celery, and bell peppers. Salt and wilt over MEDIUM
          heat, 4-5 minutes. Add sausage, ham, cayenne, and bay leaves. Stir and
          cook for 2 minutes. Add chicken and stock and stir until combined.
          Bring to boil and simmer for 2-3 hours."
      }, {
        recipe: recipe,
        order: 6,
        body: "Shred chicken. Remove bay leaves. Skim fat and set aside."
      }, {
        recipe: recipe,
        order: 7,
        body: "Serve over rice. Garnish with parsley, green onions, and/or file
          powder."
      }
    ]
    recipe_steps = []
    recipe_step_hashes.each do |recipe_step_hash|
      recipe_steps << RecipeStep.create!(recipe_step_hash)
    end

    ingredient_list_hashes = [
      { recipe: recipe,
        ingredient: ingredient("Oil", "Vegetable"),
        amount: "1/2 cup",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Sausage", "Andouille"),
        amount: "1 pound",
        preparation: "cut into 1/2-inch thick pieces",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Chicken Thighs"),
        amount: "4 pounds",
        preparation: "skinless boneless",
        step: 3
      }, {
        recipe: recipe,
        ingredient: ingredient("Ham", "Smoked"),
        amount: "1/2 pound",
        preparation: "cubed",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Flour"),
        amount: "1 Cup",
        step: 4
      }, {
        recipe: recipe,
        ingredient: ingredient("Onions"),
        amount: "2 cups",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Celery"),
        amount: "1 cup",
        preparation: "chopped",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Bell Peppers"),
        amount: "1 cup",
        preparation: "chopped",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Bay Leaves"),
        amount: "3",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Chicken Stock"),
        amount: "9 cups",
        step: 5
      }, {
        recipe: recipe,
        ingredient: ingredient("Scallions"),
        amount: "1/2 cup",
        preparation: "chopped",
        step: 7
      }, {
        recipe: recipe,
        ingredient: ingredient("Parsley"),
        amount: "2 tbsp",
        preparation: "chopped",
        step: 7
      }, {
        recipe: recipe,
        ingredient: ingredient("Paprika"),
        amount: "1 1/2 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Salt"),
        amount: "2 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Garlic Powder"),
        amount: "2 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Black Pepper"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Onion Powder"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Cayenne Pepper"),
        amount: "1 tbsp",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Oregano"),
        amount: "1 tbsp",
        preparation: "dried",
        step: 1
      }, {
        recipe: recipe,
        ingredient: ingredient("Thyme"),
        amount: "1 tbsp",
        preparation: "dried",
        step: 1
      }
    ]
    ingredient_list_hashes.each do |ingredient_list_hash|
      IngredientList.create!(ingredient_list_hash)
    end
    recipe.categories << category("Winter")
    recipe.categories << category("Soup")
    recipe.categories << category("Fall")
  end
end
