class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.integer :level, :null => false
      t.integer :hours_per_week
      t.timestamps
    end
    add_index :subjects, [:user_id, :name, :level], :unique => true
  end
end
