class ShoppingListsController < ApplicationController
  def show
    @shopping_list = current_user.cart.shopping_list
  end

  def new
    @shopping_list = current_user.cart.shopping_list
    temp_cart = current_user.cart
    temp_cart.ordered = true
    temp_cart.save
  end
end
