class SubjectRoomRelation < ActiveRecord::Base
  belongs_to :subject
  belongs_to :room

  validates :room, :presence => true
  validates :subject, :presence => true
  validates_uniqueness_of :room_id, :scope => [:subject_id]

  default_scope :order => 'subject_room_relations.id'

  attr_accessible :room, :subject
end
