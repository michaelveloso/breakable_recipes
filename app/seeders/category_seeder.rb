require 'csv'

class CategorySeeder
  def self.seed!
    csv = File.read(Rails.root + "app/seeders/csv/categories.csv")
    categories = CSV.parse(csv, headers: true)
    categories.each do |category|
      Category.create(category.to_hash)
    end
  end
end
