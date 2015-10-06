class IngredientSeeder
  INGREDIENTS = [
    { name: "Bacon" },
    { name: "Bell Peppers", subtype: "Red" },
    { name: "Chili-garlic Paste" },
    { name: "Cilantro" },
    { name: "Corn" },
    { name: "Crushed Red Pepper" },
    { name: "Cucumber" },
    { name: "Garlic" },
    { name: "Ginger" },
    { name: "Mint" },
    { name: "Rice Noodles" },
    { name: "Oil", subtype: "Sesame" },
    { name: "Onion", subtype: "Red" },
    { name: "Paprika" },
    { name: "Peanut Butter", subtype: "Smooth" },
    { name: "Peanuts", subtype: "Roasted Salted" },
    { name: "Potatoes", subtype: "Yukon Gold" },
    { name: "Salt" },
    { name: "Sesame Paste" },
    { name: "Soy Sauce" },
    { name: "Sugar", subtype: "Brown" },
    { name: "Tomatoes", subtype: "Plum" },
    { name: "Vinegar", subtype: "Cider" },
    { name: "Vinegar", subtype: "Rice" }
  ]

  def self.seed!
    INGREDIENTS.each do |ingredient|
      Ingredient.create(ingredient)
    end
  end
end
