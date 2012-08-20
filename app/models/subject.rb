class Subject < ActiveRecord::Base
  belongs_to :user

  has_many :subject_room_relations
  has_many :rooms, :through => :subject_room_relations

  has_many :teacher_subject_relations
  has_many :teachers, :through => :teacher_subject_relations

  has_many :klass_subject_relations
  has_many :klasses, :through => :klass_subject_relations

  default_scope :order => 'subjects.id'

  attr_accessible :user, :name, :level, :hours_per_week

  validates :user, :presence => true
  validates :name, :presence => true, :length   => { :maximum => 100 }
  validates :level, :presence => true, :inclusion => { :in => 0..9 }
  validates :hours_per_week, :presence => true, :inclusion => { :in => 1..80 }

end
