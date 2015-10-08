class RecipeStep < ActiveRecord::Base
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :body, presence: true
  validates :order, numericality: { only_integer: true, greater_than: 0 }
  validates :recipe_id, uniqueness: { scope: :order }
end
