class AddSharingToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :shared, :boolean, default: false
  end
end
