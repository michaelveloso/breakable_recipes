class IngredientSeeder
  INGREDIENTS = [
    {
      name: "Tomatoes",
      subtype: "Plum"
    }, {
      name: "Paprika"
    }
  ]

  def self.seed!
    INGREDIENTS.each do |ingredient|
      Ingredient.create!(ingredient)
    end
  end
end
