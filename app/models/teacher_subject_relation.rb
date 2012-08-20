class TeacherSubjectRelation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :subject

  validates :teacher, :presence => true
  validates :subject, :presence => true
  validates_uniqueness_of :subject_id, :scope => [:teacher_id]

  attr_accessible :teacher, :subject
end
