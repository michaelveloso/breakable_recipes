class RecipeCart < ActiveRecord::Base
  belongs_to :user
  has_many :carted_recipes
  has_many :recipes, through: :carted_recipes

  def shopping_list
    ingredient_lists = []
    recipes.each do |recipe|
      recipe.ingredient_lists.each do |ingredient_list|
        ingredient_lists << ingredient_list
      end
    end
    ingredient_lists.flatten!
    ingredient_lists.sort_by! { |il| il.ingredient.to_s }
    ingredient_lists.map! { |il| il.to_s }
  end
end
