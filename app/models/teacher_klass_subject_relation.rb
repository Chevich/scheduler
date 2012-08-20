class TeacherKlassSubjectRelation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :klass
  belongs_to :subject

  validates :teacher, :presence => true
  validates :klass, :presence => true
  validates :subject, :presence => true
  validates_uniqueness_of :subject_id, :scope => [:teacher_id, :klass_id]

  attr_accessible :klass, :subject, :teacher
end
