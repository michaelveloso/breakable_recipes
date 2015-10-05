class RecipeStep < ActiveRecord::Base
  has_many :ingredient_lists
  has_many :ingredients, through: :ingredient_lists
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :body, presence: true
  validates :order, numericality: { only_integer: true, greater_than: 0 }
  validates :recipe_id, uniqueness: { scope: :order }
end
