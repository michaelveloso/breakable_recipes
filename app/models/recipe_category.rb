class RecipeCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :recipe_id, uniqueness: { scope: :category_id }
  validates :category_id, presence: true
  validates :category_id, uniqueness: { scope: :recipe_id }
end
