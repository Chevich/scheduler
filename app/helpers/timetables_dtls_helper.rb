module TimetablesDtlsHelper
  def get_subject(array, day, lesson, klass)
    s = array.where("day = ? and lesson = ? and klass_id = ?",day, lesson, klass.id).first
    s.nil? ? '----' : s.subject.name
  end

  def get_room(array, day, lesson, klass)
    s = array.where("day = ? and lesson = ? and klass_id = ?",day, lesson, klass.id).first
    s.nil? ? '' : s.room.number
  end

  def get_teacher(array, day, lesson, klass)
    s = array.where("day = ? and lesson = ? and klass_id = ?",day, lesson, klass.id).first
    s.nil? ? '' : s.teacher.fio
  end

end
