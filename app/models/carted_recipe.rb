class CartedRecipe < ActiveRecord::Base
  belongs_to :recipe_cart
  belongs_to :recipe
end
