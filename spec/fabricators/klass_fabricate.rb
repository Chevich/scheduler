#coding: utf-8
Fabricator(:klass) do
  user {User.first || Fabricate(:user)}
  name '7a'
  level 7
end
