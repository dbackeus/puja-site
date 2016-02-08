class AddTokenToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :token, :string
    add_index :registrations, :token, unique: true
  end
end
