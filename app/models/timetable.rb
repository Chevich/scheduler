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
      current_user.klasses.each do |klass|
        klass.klass_subject_relations.each do |relation|
          subject = relation.subject
          hours_per_week = relation.hours_per_week
          hours = 0
          table.each do |row|
            hours = hours + 1 if row[:klass] == klass && row[:subject] == subject
          end
          return false unless hours == hours_per_week
        end
      end
      false
    end

    def self.calc(current_user, min_day, min_lesson, table)
      (min_day..6).each do |day| # дни недели
        (min_lesson..2).each do |lesson| # номер урока
          current_user.klasses.each do |klass|
            klass.klass_subject_relations.each do |klass_subject|
              subject = klass_subject.subject
              hours_per_week = klass_subject.hours_per_week
              subject.teachers.each do |teacher|
                teacher.teacher_klass_subject_relations.each do |relation|
                  if relation.klass == klass && relation.subject == subject
                    if validate(table, day,lesson,subject, klass, hours_per_week)
                      table << {day:day, lesson:lesson, klass:klass, subject:subject}
                      table.pop unless calc(current_user,day,lesson,table)
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



    table = Array.new
    calc(current_user,1,1,table)
    table
  end
end
