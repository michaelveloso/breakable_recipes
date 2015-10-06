class AddPreparationToIngredientLists < ActiveRecord::Migration
  def change
    add_column :ingredient_lists, :preparation, :string
  end
end
