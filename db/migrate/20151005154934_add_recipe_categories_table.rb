class AddRecipeCategoriesTable < ActiveRecord::Migration
  def change
    create_table :recipe_categories do |t|
      t.integer :category_id, null: false
    end
  end
end
