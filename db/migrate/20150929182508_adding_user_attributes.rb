class AddingUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :username, :string, null: false
    add_column :users, :role, :string, null: false, default: 'member'
    add_index :users, :username, unique: true
  end
end
