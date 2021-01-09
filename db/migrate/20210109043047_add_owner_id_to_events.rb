class AddOwnerIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :owner, foreign_key: { to_table: :users }
  end
end
