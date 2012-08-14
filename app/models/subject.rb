class Subject < ActiveRecord::Base
  belongs_to :user

  has_many :subject_room_relations
  has_many :rooms, :through => :subject_room_relations

  has_many :teacher_subject_relations
  has_many :teachers, :through => :teacher_subject_relations

  has_many :klass_subject_relations
  has_many :klasses, :through => :klass_subject_relations

  attr_accessible :user, :name, :level, :hours_per_week
end
