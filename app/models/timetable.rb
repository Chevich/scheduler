class Timetable < ActiveRecord::Base
  has_many :timetable_dtls

  attr_accessible :user, :version, :comment

  def self.re_calculate(current_user)

    def self.validate(table, day, lesson, subject, klass, hours_per_week)
      hour_count = 0
      table.each do |row|
        # был ли в этот день уже такой урок в данном классе
        if row[:day] == day && row[:subject] == subject && row[:klass] == klass
          return false
        end
        # был ли в предыдущий или последующий день уже такой урок в данном классе (если часов в неделю меньше 4)
        if hours_per_week < 4 && (row[:day] - day).abs <= 1 && row[:subject] == subject && row[:klass] == klass
          return false
        end
        # свободен ли для вставки данный урок
        if row[:day] == day && row[:lesson] == lesson && row[:klass] == klass
          return false
        end
        # сколько часов в неделю данный урок уже выставлен в расписании
        hour_count = hour_count + 1 if row[:subject] == subject && row[:klass] == klass
        if hour_count >= hours_per_week
          return false
        end
      end
      return true
    end

    #def self.calc(current_user, min_day, min_lesson, table)
    #  (min_day..6).each do |day| # дни недели
    #    (min_lesson..2).each do |lesson| # номер урока
    #      current_user.klasses.each do |klass|
    #        klass.klass_subject_relations.each do |klass_subject|
    #          subject = klass_subject.subject
    #          hours_per_week = klass_subject.hours_per_week
    #          subject.teachers.each do |teacher|
    #            teacher.teacher_klass_subject_relations.each do |relation|
    #              if relation.klass == klass && relation.subject == subject
    #                if validate(table, day,lesson,subject, klass, hours_per_week)
    #                  table << {day:day, lesson:lesson, klass:klass, subject:subject}
    #                end
    #              end
    #            end
    #          end
    #        end
    #      end
    #    end
    #  end
    #end

    def self.check_timeline(current_user, table)
      puts 'enter'
      result = true
      current_user.klasses.each do |klass|
        if result
          klass.klass_subject_relations.each do |relation|
            if result
              subject = relation.subject
              hours_per_week = relation.hours_per_week
              hours = 0
              table.each do |row|
                hours += 1 if row[:klass] == klass && row[:subject] == subject
              end
              result = false if hours > hours_per_week
            end
          end
        end
      end
      puts "result = #{result}"
      result
    end

    def self.calc_this(current_user, min_day, min_lesson, min_klass, min_subject, min_teacher, table)
      @level += 1
      puts "#{min_day} #{min_lesson}  k=#{min_klass} s=#{min_subject} t=#{min_teacher} (#{@level})"
      (min_day..6).each do |day| # дни недели
        (min_lesson..2).each do |lesson| # номер урока
          current_user.klasses.each_with_index do |klass, klass_index|
            klass.klass_subject_relations.each_with_index do |klass_subject, subject_index|
              subject = klass_subject.subject
              hours_per_week = klass_subject.hours_per_week
              subject.teachers.each_with_index do |teacher, teacher_index|
                teacher.teacher_klass_subject_relations.each do |relation|
                  if relation.klass == klass && relation.subject == subject
                    if validate(table, day,lesson,subject, klass, hours_per_week)
                      table << {day:day, lesson:lesson, klass:klass, subject:subject}
                      until calc_this(current_user, day, lesson, klass_index, subject_index, teacher_index, table)
                        table.pop
                        @level -=1
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      check_timeline(current_user, table)
    end

    def self.calc(current_user, table)
      calc_this(current_user,1,1,-1,-1,-1,table)
    end



    @level = 0
    table = Array.new
    calc(current_user,table)
    table
  end
end
