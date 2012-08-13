class RoomSubjectRelation < ActiveRecord::Base
  belongs_to :room
  belongs_to :subject
end
