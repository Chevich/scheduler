class Room < ActiveRecord::Base
  belongs_to :user

  has_many :teacher_room_relations
  has_many :teachers, :through => :teacher_room_relations

  has_many :subject_room_relations
  has_many :subjects, :through => :subject_room_relations


  attr_accessible :user, :name, :number

  validates :user, :presence => true
  validates :name, :presence => true, :length   => { :maximum => 100 }
  validates :number, :presence => true, :length   => { :maximum => 10 }

end
