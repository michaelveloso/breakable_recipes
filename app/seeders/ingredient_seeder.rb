class UserSeeder
  INGREDIENTS = [
    {
      name: "Tomatoes",
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
