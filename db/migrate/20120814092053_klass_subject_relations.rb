class KlassSubjectRelations < ActiveRecord::Migration
  def change
    create_table :klass_subject_relations do |t|
      t.integer :klass_id, :null => false
      t.integer :subject_id, :null => false
      t.integer :hours_per_week, :null => false
    end
    add_index :klass_subject_relations, [:klass_id,:subject_id], :unique => true
    add_index :klass_subject_relations, :klass_id
    add_index :klass_subject_relations, :subject_id
  end
end
