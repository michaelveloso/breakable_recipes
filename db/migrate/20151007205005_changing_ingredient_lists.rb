class ChangingIngredientLists < ActiveRecord::Migration
  def change
    add_column :ingredient_lists, :step, :integer
    remove_column :ingredient_lists, :recipe_step_id, :integer
  end
end
