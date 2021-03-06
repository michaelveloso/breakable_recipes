class IngredientList < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :recipe_id, uniqueness: { scope: :ingredient_id }
  validates :ingredient_id, presence: true
  validates :ingredient_id, uniqueness: { scope: :recipe_id }
  validates :step, numericality: {
    allow_nil: true,
    only_integer: true,
    greater_than: 0 }

  def to_s
    string = "#{amount} #{ingredient}"
    string += ", #{preparation}" if preparation.present?
    string
  end
end
