class TeacherRoomRelation < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :room

  validates :room, :presence => true
  validates :teacher, :presence => true
  validates_uniqueness_of :room_id, :scope => [:teacher_id]

  attr_accessible :teacher, :room

end
