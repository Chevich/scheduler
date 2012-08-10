class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :fio
      t.timestamps
    end
    add_index :teachers, :fio, :unique => true
  end
end
