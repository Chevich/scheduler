class CreateTimetablesDtl < ActiveRecord::Migration
  def change
    create_table :timetables_dtls do |t|
      t.integer :timetable_id, :null => false
      t.integer :day, :null => false
      t.integer :lesson, :null => false
      t.integer :klass_id, :null => false
      t.integer :subject_id, :null => false
      t.integer :teacher_id, :null => false
      t.integer :room_id, :null => false
    end
  end
end
