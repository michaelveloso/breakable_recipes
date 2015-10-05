class AddIngredientLists < ActiveRecord::Migration
  def change
    create_table :ingredient_lists do |t|
      t.integer :ingredient_id, null: false
      t.string :amount
    end
  end
end
