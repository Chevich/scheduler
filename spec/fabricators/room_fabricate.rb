#coding: utf-8
Fabricator(:room) do
  user {User.first || Fabricate(:user)}
  name 'Математика'
  number '403'
end
