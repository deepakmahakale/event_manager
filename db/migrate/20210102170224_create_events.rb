class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.boolean :all_day, default: false

      t.timestamps
    end
  end
end
