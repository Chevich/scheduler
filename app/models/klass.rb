class Klass < ActiveRecord::Base
  belongs_to :user
  has_many :klass_subject_relations
  has_many :subjects, :through => :klass_subject_relations

  has_many :teacher_klass_subject_relations
  has_many :teachers, :through => :teacher_klass_subject_relations


  attr_accessible :user, :name, :level
end
