class AddIpAddressToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :ip_address, :string
  end
end
