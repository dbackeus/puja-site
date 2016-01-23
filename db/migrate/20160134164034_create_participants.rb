class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :gender
      t.string :age
      t.belongs_to :registration, index: true, foreign_key: true

      t.timestamps
    end
  end
end
