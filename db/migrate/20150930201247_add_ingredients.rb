class AddIngredients < ActiveRecord::Migration
  def change
    create_table(:ingredients) do |table|
      table.string :name, null: false
    end
    add_index :ingredients, :name, unique: true
  end
end
