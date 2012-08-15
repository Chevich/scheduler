class TeacherKlassSubjectRelation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :klass
  belongs_to :subject
end
