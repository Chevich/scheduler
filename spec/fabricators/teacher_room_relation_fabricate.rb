#coding: utf-8
Fabricator(:teacher_room_relation) do
  teacher {Teacher.first || Fabricate(:teacher)}
  room {Room.first || Fabricate(:room)}
end
