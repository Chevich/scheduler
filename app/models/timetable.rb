class Timetable < ActiveRecord::Base
  has_many :timetables_dtls, :dependent => :delete_all
  belongs_to :user

  attr_accessible :user, :version, :comment

  def self.re_calculate(current_user)

    def self.validate(table, day, lesson, subject, klass, hours_per_week, room, teacher)
      hour_count = 0
      prev_lessons = 0
      table.each do |row|
        # был ли в этот день уже такой урок в данном классе
        if row[:day] == day && row[:subject] == subject && row[:klass] == klass
          return false
        end
        # был ли в предыдущий или последующий день уже такой урок в данном классе (если часов в неделю меньше 4)
        if hours_per_week < 3 && (row[:day] - day).abs <= 1 && row[:subject] == subject && row[:klass] == klass
          return false
        end
        # свободен ли для вставки данный урок
        if row[:day] == day && row[:lesson] == lesson && row[:klass] == klass
          return false
        end
        # свободен ли кабинет для урока?
        if row[:day] == day && row[:lesson] == lesson && row[:room] == room
          return false
        end
        # свободен ли учитель для урока?
        if row[:day] == day && row[:lesson] == lesson && row[:teacher] == teacher
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

    def self.check_bingo(current_user,table)
      @ks.each do |item|
        return false until item[:taken]
      end
      # сохраняем данное расписание
      @version += 1
      puts "BINGO! (#@version)"
      tt = current_user.timetables.new()
      tt.version = @version
      tt.comment = ''
      tt.save!
      table.each do |row|
        td = tt.timetables_dtls.new()
        td.day = row[:day]
        td.lesson = row[:lesson]
        td.klass_id = row[:klass].id
        td.subject_id = row[:subject].id
        td.teacher_id = row[:teacher].id
        td.room_id = row[:room].id
        td.save!
      end
      @evaluate = false
      true
    end

    def self.get_rooms(teacher, subject)
      # если можно вести предмет там где хочет учитель то вначале списка выставляем его
      if subject.rooms.empty?
        #  можно вести в любом кабинете
        teacher.rooms
      else
        #  можно вести только в конкретном кабинете
        subject.rooms
      end
    end

    def self.calc_this(current_user, table)
      @level += 1
      current_user.klasses.each_with_index do |klass, klass_index|
        (1..klass.days_per_week).each do |day| # дни недели
          (1..klass.lessons_per_day).each do |lesson| # номер урока
            @ks.each do |klass_subject|
              if klass_subject[:klass] == klass && !klass_subject[:taken] && @evaluate
                subject = klass_subject[:subject]
                subject.teachers.each do |teacher|
                  teacher.teacher_klass_subject_relations.each do |relation|
                    if relation.klass == klass && relation.subject == subject && @evaluate
                      get_rooms(teacher,subject).each do |room|
                        if !klass_subject[:taken] && validate(table, day, lesson, subject, klass, klass_subject[:hours_per_week], room, teacher) && @evaluate
                          #puts "insert #{day} #{lesson} #{subject.name} #{klass.name} #{room.number} #{teacher.fio} (#{@level})"
                          table << {day:day, lesson:lesson, klass:klass, subject:subject, room: room, teacher: teacher}
                          klass_subject[:taken] = true
                          check_bingo(current_user,table)
                          calc_this(current_user,table)
                          table.pop
                          klass_subject[:taken] = false
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
      @level -=1
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
      #print_ks
      calc_this(current_user,table)
    end


    puts '======================================================='
    current_user.timetables.delete_all
    @level = 0
    @ks = Array.new
    @version = 0
    @evaluate = true
    table = Array.new
    calc(current_user,table)
    table
  end
end
