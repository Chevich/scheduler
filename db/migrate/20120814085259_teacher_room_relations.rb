class TeacherRoomRelations < ActiveRecord::Migration
  def change
    create_table :teacher_room_relations do |t|
      t.integer :teacher_id, :null => false
      t.integer :room_id, :null => false
    end
    add_index :teacher_room_relations, [:teacher_id,:room_id], :unique => true
    add_index :teacher_room_relations, :teacher_id
    add_index :teacher_room_relations, :room_id
  end
end
