class Teacher < ActiveRecord::Base
  belongs_to :user

  has_many :teacher_subject_relations, :dependent => :delete_all
  has_many :subjects, :through => :teacher_subject_relations

  has_many :teacher_room_relations, :dependent => :delete_all
  has_many :rooms, :through => :teacher_room_relations

  has_many :teacher_klass_subject_relations, :dependent => :delete_all
  has_many :klasses, :through => :teacher_klass_subject_relations

  default_scope :order => 'teachers.id'

  attr_accessible :user, :fio

  validates :user, :presence => true
  validates :fio, :presence => true, :length   => { :maximum => 100 }
end
