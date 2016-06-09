class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.integer :amount
      t.string :stripe_customer_id
      t.string :stripe_charge_id
      t.string :stripe_token
      t.string :email

      t.timestamps
    end
  end
end
