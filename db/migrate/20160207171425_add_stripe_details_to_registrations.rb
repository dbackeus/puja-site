class AddStripeDetailsToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :stripe_customer_id, :string
    add_column :registrations, :stripe_charge_id, :string
    add_column :registrations, :stripe_token, :string
  end
end
