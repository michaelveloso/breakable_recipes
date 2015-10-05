class Ingredient < ActiveRecord::Base
  has_many :ingredient_lists
  has_many :recipes, through: :ingredient_lists

  validates :name, presence: true
  validates :name, uniqueness: { scope: :subtype }

  def description
    string = "#{name}"
    string << ", #{subtype}" if subtype.present?
    string
  end
end
