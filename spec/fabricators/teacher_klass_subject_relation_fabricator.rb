#coding: utf-8
Fabricator(:teacher_klass_subject_relation) do
  teacher {Teacher.first || Fabricate(:teacher)}
  klass {Klass.first || Fabricate(:klass)}
  subject {Subject.first || Fabricate(:subject)}
end
