class Timetable < ActiveRecord::Base
  has_many :timetables_dtls, :dependent => :delete_all
  belongs_to :user

  default_scope :order => 'timetables.id'

  attr_accessible :user, :version, :comment

  def self.re_calculate(current_user)

    def self.validate(day, lesson, subject, klass, hours_per_week, room, teacher)
      hour_count = 0
      prev_lessons = 0
      @table.each do |row|
        # был ли в этот день уже такой урок в данном классе
        if row[:day] == day && row[:subject] == subject && row[:klass] == klass
          return false
        end
        # между сохраненным днем и текущим разница не больше чем можно классу
        if (row[:day] - day).abs >= klass.days_per_week && row[:klass] == klass
          return false
        end
        ## был ли в предыдущий или последующий день уже такой урок в данном классе (если часов в неделю меньше 4)
        #if hours_per_week < 3 && (row[:day] - day).abs <= 1 && row[:subject] == subject && row[:klass] == klass
        #  return false
        #end
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

    def self.check_day_lesson_klass(day, lesson, klass)
      @table.each do |row|
        # свободен ли для вставки данный урок
        if row[:day] == day && row[:lesson] == lesson && row[:klass] == klass
          return false
        end
      end
      return true
    end

    def self.check_bingo(current_user, should_save = true)
      @klass_subject_relation.each do |item|
        return false until item[:taken]
      end
      # сохраняем данное расписание
      @version += 1
      time_save = Time.now
      #puts "BINGO! (#@version)"
      if should_save
        tt = current_user.timetables.new()
        tt.version = @version
        tt.comment = ''
        tt.save!
        @table.each do |row|
          td = tt.timetables_dtls.new()
          td.day = row[:day]
          td.lesson = row[:lesson]
          td.klass_id = row[:klass].id
          td.subject_id = row[:subject].id
          td.teacher_id = row[:teacher].id
          td.room_id = row[:room].id
          td.save!
        end
      end
      @save_time += Time.now.minus_with_coercion(time_save)
      @evaluate = false if @version >= 30
      true
    end

    def self.get_rooms(teacher, subject)
      # если можно вести предмет там где хочет учитель то вначале списка выставляем его
      rooms = @subject_room_relation.map { |item| item[:room] if item[:subject] == subject }.compact

      if rooms.empty?
        #  можно вести в любом кабинете
        rooms = @teacher_room_relation.map { |item| item[:room] if item[:teacher] == teacher }.compact
      end
      rooms
    end

    def self.teachers_by_subject(subject)
      @teacher_subject_relation.map { |item| item[:teacher] if item[:subject] == subject }.compact
    end

    def self.get_relation(teacher, klass, subject)
      @teacher_klass_subject_relation.map { |item| item[:teacher] if item[:teacher] == teacher && item[:klass] == klass && item[:subject] == subject }.compact
    end

    def self.get_relation_by_klass(klass)
      @teacher_klass_subject_relation.map { |item| item if item[:klass] == klass }.compact
    end

    def self.get_klass_subject(klass, subject)
      @klass_subject_relation.each do |item|
        if item[:klass] == klass && item[:subject] == subject && !item[:taken]
          return item
        end
        nil
      end.first
    end

    def self.calc_this(current_user, min_klass_index, min_day, min_lesson)
      @level += 1
      current_user.klasses.each_with_index do |klass, klass_index|
        @days.each do |day| # дни недели
          (1..klass.lessons_per_day).each do |lesson| # номер урока
            if check_day_lesson_klass(day, lesson, klass)
              get_relation_by_klass(klass).each do |relation|
                return until @evaluate
                teacher = relation[:teacher]
                subject = relation[:subject]
                klass_subject = get_klass_subject(klass, subject)
                if klass_subject
                  get_rooms(teacher,subject).each do |room|
                    if validate(day, lesson, subject, klass, klass_subject[:hours_per_week], room, teacher) && @evaluate
                      #puts "insert #{day} #{lesson} #{subject.name} #{klass.name} #{room.number} #{teacher.fio} (#@level)"
                      @table << {day:day, lesson:lesson, klass:klass, subject:subject, room: room, teacher: teacher}
                      klass_subject[:taken] = true
                      check_bingo(current_user)
                      calc_this(current_user, klass_index, day, lesson)
                      @table.pop
                      klass_subject[:taken] = false
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

    def self.calc(current_user)
      # Сохраняем klass_subject для дальнейшего использования
      time_init = Time.now
      current_user.klasses.each do |klass|
        @klass_subject_relation += klass.klass_subject_relations.inject([]) do |array, item|
          temp = []
          item.hours_per_week.times do
            temp << {klass:item.klass, subject:item.subject, hours_per_week:item.hours_per_week, taken:false}
          end
          array += temp
        end
      end
      # Сохраняем teacher_subject для дальнейшего использования
      current_user.teachers.each do |teacher|
        teacher.teacher_subject_relations.each do |item|
          @teacher_subject_relation << {teacher:item.teacher, subject:item.subject}
        end
      end
      # Сохраняем teacher_room для дальнейшего использования
      current_user.teachers.each do |teacher|
        teacher.teacher_room_relations.each do |item|
          @teacher_room_relation << {teacher:item.teacher, room:item.room}
        end
      end
      # Сохраняем subject_room для дальнейшего использования
      current_user.subjects.each do |subject|
        subject.subject_room_relations.each do |item|
          @subject_room_relation << {subject:item.subject, room:item.room}
        end
      end
      # Сохраняем teacher_klass_subject_relations для дальнейшего использования
      current_user.klasses.each do |klass|
        klass.teacher_klass_subject_relations.each do |item|
          @teacher_klass_subject_relation << {teacher:item.teacher, klass:klass, subject:item.subject}
        end
      end
      @init_time += Time.now.minus_with_coercion(time_init)
      calc_this(current_user,0,1,1)
    end


    time = Time.now()
    @save_time = 0
    @init_time = 0
    current_user.timetables.delete_all
    @level = 0
    @klass_subject_relation = Array.new
    @teacher_subject_relation = []
    @teacher_room_relation = []
    @subject_room_relation = []
    @teacher_klass_subject_relation = []
    @version = 0
    @evaluate = true
    @table = Array.new
    @days = Setting.week_days
    calc(current_user)
    calc_time = Time.now.minus_with_coercion(time)
    puts "DONE for #{calc_time} seconds. Save time = #{@save_time}. Init time = #{@init_time}. Calculation time = #{calc_time - @save_time- @init_time}"
    @table
  end
end
