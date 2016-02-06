class AddPaymentInfoToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :extra, :float
    add_column :registrations, :paid, :boolean, default: false, null: false
  end
end
