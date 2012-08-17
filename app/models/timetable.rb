class Timetable < ActiveRecord::Base
  has_many :timetable_dtls

  attr_accessible :user, :version, :comment

  def self.re_calculate(current_user)
    def self.check_subjects
      true
    end

    table = Array.new
    (1..7).each do |day| # дни недели
      (1..4).each do |lesson| # номер урока
        current_user.klasses.each do |klass|
          klass.subjects.each do |subject|
            if check_subjects
              subject.teachers do |teacher|
                teacher.teacher_klass_subject_relations.each do |relation|
                  if relation.klass == klass && relation.subject == subject
                    table << {day:day, lesson:lesson, klass:klass.name}
                  end
                end
              end
            end
          end
        end
      end
    end
    table
  end
end
