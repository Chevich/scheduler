#coding: utf-8
Fabricator(:teacher) do
  user {User.first || Fabricate(:user)}
  fio 'Иванов И.И.'
end
