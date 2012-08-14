class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :user_id, :null => false
      t.string :fio, :null => false
      t.timestamps
    end
    add_index :teachers, [:user_id, :fio], :unique => true
  end
end
