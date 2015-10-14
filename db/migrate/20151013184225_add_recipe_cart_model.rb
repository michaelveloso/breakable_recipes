class AddRecipeCartModel < ActiveRecord::Migration
  def change
    create_table :recipe_carts do |t|
      t.integer :user_id, null: false
      t.boolean :ordered, default: false

      t.timestamps
    end

    create_table :carted_recipes do |t|
      t.integer :recipe_id, null: false
      t.integer :recipe_cart_id, null: false
    end
  end
end
