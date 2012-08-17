#coding: utf-8
Fabricator(:subject_room_relation) do
  subject {Subject.first || Fabricate(:subject)}
  room {Room.first || Fabricate(:room)}
end
