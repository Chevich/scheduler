class TeacherSubjectRelation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :subject

  validates :teacher, :presence => true
  validates :subject, :presence => true
  validates_uniqueness_of :subject_id, :scope => [:teacher_id]

  default_scope :order => 'teacher_subject_relations.id'

  attr_accessible :teacher, :subject
end
