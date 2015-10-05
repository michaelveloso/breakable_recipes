class AddRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :cooking_time, default: 0
      t.integer :num_served_min, default: 0
      t.integer :num_served_max, default: 0
      t.integer :complexity, default: 0

      t.timestamps
    end

    add_index :recipes, :name, unique: true

    add_column :ingredient_lists, :recipe_id, :integer, null: false
    add_column :ingredient_lists, :recipe_step_id, :integer
    add_index :ingredient_lists, [:recipe_id, :ingredient_id], unique: true

    add_column :recipe_steps, :recipe_id, :integer, null: false
    add_index :recipe_steps, [:recipe_id, :order], unique: true

    add_column :recipe_categories, :recipe_id, :integer, null: false
    add_index :recipe_categories, [:recipe_id, :category_id], unique: true
  end
end
