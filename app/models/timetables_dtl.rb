class TimetablesDtl < ActiveRecord::Base
  belongs_to :timetable

  attr_accessible :day, :lesson, :klass_id, :subject_id, :teacher_id, :room_id, :timetable_id

  def klass
    Klass.find(klass_id)
  end

  def subject
    Subject.find(subject_id)
  end

  def room
    Room.find(room_id)
  end

  def teacher
    Teacher.find(teacher_id)
  end

end
