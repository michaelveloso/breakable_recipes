class AddRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.string :body, null: false
      t.integer :order, null: false
    end
  end
end
