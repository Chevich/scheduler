class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.integer :user_id, :null => false
      t.string :version, :null => false
      t.string :comment, :null => false
      t.timestamps
    end
  end
end
