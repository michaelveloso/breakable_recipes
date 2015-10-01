class AddIngredients < ActiveRecord::Migration
  def change
    create_table(:ingredients) do |table|
      table.string :name, null: false
      table.string :subtype
    end
    add_index :ingredients, [:name, :subtype], unique: true
  end
end
