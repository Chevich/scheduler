class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name, :null => false
      t.integer :level, :null => false
      t.integer :hours_per_week, :null => false
      t.timestamps
    end
    add_index :subjects, [:name, :level], :unique => true
  end
end
