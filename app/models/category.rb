class Category < ActiveRecord::Base
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.options_for_select
    options = [['(Choose a category)', nil]]
    self.order(:name).each do |category|
      options << [category.name, category.id]
    end
    options
  end
end
