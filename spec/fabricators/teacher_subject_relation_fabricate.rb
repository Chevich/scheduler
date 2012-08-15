#coding: utf-8
Fabricator(:teacher_subject_relation) do
  teacher {Teacher.first || Fabricate(:teacher)}
  subject {Subject.first || Fabricate(:subject)}
end
