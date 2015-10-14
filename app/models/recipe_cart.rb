class RecipeCart < ActiveRecord::Base
  belongs_to :user
  has_many :carted_recipes
  has_many :recipes, through: :carted_recipes
end
