module TimetablesHelper
  def get_subject(array, day, lesson, klass)
    unless array.nil?
      array.each do |row|
        if row[:day] == day && row[:lesson] == lesson && row[:klass] == klass
          return row[:subject].name
          #return "#{day} #{lesson} #{klass.name}"
          #return "#{row.inspect}"
        end
      end
    end
    "----"
  end

  def get_room(array, day, lesson, klass)
    unless array.nil?
      array.each do |row|
        if row[:day] == day && row[:lesson] == lesson && row[:klass] == klass
          return "(#{row[:room].number})"
          #return "#{day} #{lesson} #{klass.name}"
          #return "#{row.inspect}"
        end
      end
    end
    ""
  end

  def get_teacher(array, day, lesson, klass)
    unless array.nil?
      array.each do |row|
        if row[:day] == day && row[:lesson] == lesson && row[:klass] == klass
          return "(#{row[:teacher].fio})"
          #return "#{day} #{lesson} #{klass.name}"
          #return "#{row.inspect}"
        end
      end
    end
    ""
  end


end
