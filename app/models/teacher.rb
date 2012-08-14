class Teacher < ActiveRecord::Base
  belongs_to :user

  has_many :teacher_subject_relations
  has_many :subjects, :through => :teacher_subject_relations

  has_many :teacher_room_relations
  has_many :rooms, :through => :teacher_room_relations

  attr_accessible :user, :fio
end
