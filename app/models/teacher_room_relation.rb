class TeacherRoomRelation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :room

  validates :room, :presence => true
  validates :teacher, :presence => true
  validates_uniqueness_of :room_id, :scope => [:teacher_id]

  default_scope :order => 'teacher_room_relations.id'

  attr_accessible :teacher, :room

end
