class CategorySeeder
  CATEGORIES = [
    { name: "Asian"},
    { name: "Italian"},
    { name: "Pasta"},
    { name: "Vegetarian"}
  ]

  def self.seed!
    CATEGORIES.each do |category|
      Category.create!(category)
    end
  end
end
