class IngredientSeeder

  def self.seed!
    csv = File.read(Rails.root + "app/seeders/csv/ingredients.csv")
    ingredients = CSV.parse(csv, headers: true)
    ingredients.each do |ingredient|
      Ingredient.create(ingredient.to_hash)
    end
  end
end
