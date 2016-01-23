class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.string :email
      t.string :phone
      t.boolean :transport
      t.string :country

      t.timestamps
    end
  end
end
