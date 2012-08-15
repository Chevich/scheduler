#coding: utf-8
Fabricator(:klass_subject_relation) do
  klass {Klass.first || Fabricate(:klass)}
  subject {Subject.first || Fabricate(:subject)}
  hours_per_week 10
end
