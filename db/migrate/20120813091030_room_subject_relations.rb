class RoomSubjectRelations < ActiveRecord::Migration
  def change
    create_table :room_subject_relations do |t|
      t.integer :room_id, :null => false
      t.integer :subject_id, :null => false
    end
    add_index :room_subject_relations, [:room_id,:subject_id], :unique => true
    add_index :room_subject_relations, :room_id
    add_index :room_subject_relations, :subject_id
  end
end
