class Subject < ActiveRecord::Base
  has_many :room_subject_relations
  has_many :rooms, :through => :room_subject_relations
end
