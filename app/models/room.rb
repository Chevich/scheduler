class Room < ActiveRecord::Base
  has_many :room_subject_relations
  has_many :subjects, :through => :room_subject_relations
end
