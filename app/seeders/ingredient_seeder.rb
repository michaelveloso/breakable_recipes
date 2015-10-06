class IngredientSeeder
  INGREDIENTS = [
    { name: "Bacon" },
    { name: "Bell Peppers", subtype: "Red" },
    { name: "Chili-garlic Paste" },
    { name: "Cilantro" },
    { name: "Corn" },
    { name: "Cucumber" },
    { name: "Garlic", subtype: "Minced" },
    { name: "Ginger", subtype: "Grated" },
    { name: "Mint" },
    { name: "Rice Noodles" },
    { name: "Oil", subtype: "Sesame" },
    { name: "Onion", subtype: "Red" },
    { name: "Paprika" },
    { name: "Peanut Butter", subtype: "Smooth" },
    { name: "Peanuts", subtype: "Roasted Salted" },
    { name: "Potatoes", subtype: "Yukon Gold" },
    { name: "Soy Sauce" },
    { name: "Sugar", subtype: "Brown" },
    { name: "Tomatoes", subtype: "Plum" },
    { name: "Vinegar", subtype: "Cider" }
  ]

  def self.seed!
    INGREDIENTS.each do |ingredient|
      Ingredient.create!(ingredient)
    end
  end
end
