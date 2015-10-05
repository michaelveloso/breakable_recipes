class IngredientList < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe_step
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :recipe_id, uniqueness: { scope: :ingredient_id }
  validates :ingredient_id, presence: true
  validates :ingredient_id, uniqueness: { scope: :recipe_id }

end
