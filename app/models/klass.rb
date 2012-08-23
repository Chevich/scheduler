class Klass < ActiveRecord::Base
  belongs_to :user
  has_many :klass_subject_relations, :dependent => :delete_all
  has_many :subjects, :through => :klass_subject_relations

  has_many :teacher_klass_subject_relations, :dependent => :delete_all
  has_many :teachers, :through => :teacher_klass_subject_relations

  default_scope :order => 'klasses.id'

  attr_accessible :user, :name, :level, :days_per_week, :lessons_per_day

  validates :user, :presence => true
  validates :name, :presence => true, :length   => { :maximum => 100 }
  validates :level, :presence => true, :inclusion => { :in => 0..9 }

end
