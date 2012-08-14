class TeacherSubjectRelations < ActiveRecord::Migration
  def change
    create_table :teacher_subject_relations do |t|
      t.integer :teacher_id, :null => false
      t.integer :subject_id, :null => false
    end
    add_index :teacher_subject_relations, [:teacher_id,:subject_id], :unique => true
    add_index :teacher_subject_relations, :teacher_id
    add_index :teacher_subject_relations, :subject_id
  end
end
