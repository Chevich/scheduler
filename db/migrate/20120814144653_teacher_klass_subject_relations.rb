class TeacherKlassSubjectRelations < ActiveRecord::Migration
  def change
    create_table :teacher_klass_subject_relations do |t|
      t.integer :teacher_id, :null => false
      t.integer :klass_id, :null => false
      t.integer :subject_id, :null => false
    end
    add_index :teacher_klass_subject_relations, [:teacher_id, :klass_id, :subject_id], :unique => true, :name => 'by_klass'
    add_index :teacher_klass_subject_relations, :teacher_id
    add_index :teacher_klass_subject_relations, :klass_id
  end
end
