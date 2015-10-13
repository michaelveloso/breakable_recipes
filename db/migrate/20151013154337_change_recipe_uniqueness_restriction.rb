class ChangeRecipeUniquenessRestriction < ActiveRecord::Migration
  def up
    remove_index :recipes, :name
    add_index :recipes, [:name, :user_id], unique: true
  end

  def down
    add_index :recipes, :name, unique: true
    remove_index :recipes, [:name, :user_id]
  end
end
