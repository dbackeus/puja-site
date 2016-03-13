class AddCommentToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :comment, :text
  end
end
