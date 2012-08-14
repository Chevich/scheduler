#coding: utf-8
Fabricator(:subject) do
  user {User.first || Fabricate(:user)}
  name 'Математика'
  level 4
  hours_per_week 4
end
