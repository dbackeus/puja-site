class AddTravelDetailsToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :arrival_at, :datetime
    add_column :registrations, :departure_at, :datetime
    add_column :registrations, :arrival_flight_no, :string
    add_column :registrations, :departure_flight_no, :string
  end
end
