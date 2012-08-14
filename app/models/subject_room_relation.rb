class SubjectRoomRelation < ActiveRecord::Base
  belongs_to :subject
  belongs_to :room
end
