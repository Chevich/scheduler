#coding: utf-8
Fabricator(:klass) do
  user {User.first || Fabricate(:user)}
  name '7a'
  level 7
  days_per_week 6
  lessons_per_day 5
end
