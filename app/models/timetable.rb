class Timetable < ActiveRecord::Base
  has_many :timetable_dtls

  attr_accessible :user, :version, :comment

  def self.re_calculate(current_user)

    def self.validate(table, day, lesson, subject, klass, hours_per_week)
      hour_count = 0
      prev_lessons = 0
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
        # нельзя оставлять форточки
        # подсчитываем сколько уроков до данного уже есть в расписании
        prev_lessons += 1 if row[:day] == day && row[:klass]== klass && row[:lesson] < lesson
      end
      # нельзя оставлять форточки
      # проверим подсчитанные уроки (должно быть lesson - 1)
      if prev_lessons != (lesson -1)
        return false
      end
      return true
    end

    def self.calc_this(current_user, table)
      @level += 1
      current_user.klasses.each_with_index do |klass, klass_index|
        (1..klass.days_per_week).each do |day| # дни недели
          (1..klass.lessons_per_day).each do |lesson| # номер урока
            @ks.each_with_index do |klass_subject, subject_index|
              if klass_subject[:klass] == klass && !klass_subject[:taken]
                subject = klass_subject[:subject]
                subject.teachers.each_with_index do |teacher, teacher_index|
                  teacher.teacher_klass_subject_relations.each do |relation|
                    if relation.klass == klass && relation.subject == subject
                      if !klass_subject[:taken] && validate(table, day,lesson,subject, klass, klass_subject[:hours_per_week])
                        table << {day:day, lesson:lesson, klass:klass, subject:subject}
                        klass_subject[:taken] = true
                        until calc_this(current_user, table)
                          table.pop
                          klass_subject[:taken] = false
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
      end
    end

    def self.print_ks
      @ks.each do |item|
        puts "#{item[:klass].name} #{item[:subject].name} #{item[:taken]}"
      end
    end

    def self.calc(current_user, table)
      # Сохраняем Klass_subject для дальнейшего использования
      current_user.klasses.each do |klass|
        @ks += klass.klass_subject_relations.inject([]) do |array, item|
          temp = []
          item.hours_per_week.times do
            temp << {klass:item.klass, subject:item.subject, hours_per_week:item.hours_per_week, taken:false}
          end
          array += temp
        end
      end
      calc_this(current_user,table)
    end


    puts '======================================================='
    @level = 0
    @ks = Array.new
    table = Array.new
    calc(current_user,table)
    puts "last level = #{@level}"
    table
  end
end
