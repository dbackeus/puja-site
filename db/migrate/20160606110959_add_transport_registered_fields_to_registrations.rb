class AddTransportRegisteredFieldsToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :transport_registered_at, :datetime
  end
end
