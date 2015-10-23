class SetUpRecipeSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :recipe_id
      t.integer :user_id
    end
    add_index :subscriptions, [:recipe_id, :user_id], unique: true
  end
end
