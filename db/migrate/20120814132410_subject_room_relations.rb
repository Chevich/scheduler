class SubjectRoomRelations < ActiveRecord::Migration
  def change
    create_table :subject_room_relations do |t|
      t.integer :subject_id, :null => false
      t.integer :room_id, :null => false
    end
    add_index :subject_room_relations, [:subject_id,:room_id], :unique => true
    add_index :subject_room_relations, :subject_id
    add_index :subject_room_relations, :room_id
  end
end
