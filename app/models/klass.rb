class Klass < ActiveRecord::Base
  belongs_to :user
  has_many :klass_subject_relations
  has_many :subjects, :through => :klass_subject_relations

  has_many :teacher_klass_subject_relations
  has_many :teachers, :through => :teacher_klass_subject_relations

  default_scope :order => 'klasses.id'

  attr_accessible :user, :name, :level

  validates :user, :presence => true
  validates :name, :presence => true, :length   => { :maximum => 100 }
  validates :level, :presence => true, :inclusion => { :in => 0..9 }

end
