class AddAccommodationAndTypeToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :accommodation, :string
    add_column :registrations, :registration_type, :string
  end
end
