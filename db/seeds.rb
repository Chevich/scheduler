#coding: utf-8

user = User.create({:email => 'andy.chevich@gmail.com', :password => 'andy123'})

#version 1

#room1 = Room.create({user:user, name: '2а начальные классы', number:'201'})
#room2 = Room.create({user:user, name: '2б начальные классы', number:'202'})
#room3 = Room.create({user:user, name: 'Труд', number:'101'})
#room4 = Room.create({user:user, name: 'Спортзал', number:'102'})
#
#klass1 = Klass.create({user:user, name: '2a', level:2, days_per_week: 5, lessons_per_day: 3})
#klass2 = Klass.create({user:user, name: '2б', level:2, days_per_week: 5, lessons_per_day: 3})
#
#subject1 = Subject.create({user:user, name: 'Чтение', level:2, hours_per_week: 2})
#subject2 = Subject.create({user:user, name: 'Рисование', level:2, hours_per_week: 4})
#subject3 = Subject.create({user:user, name: 'Пение', level:2, hours_per_week: 2})
#subject4 = Subject.create({user:user, name: 'Письмо', level:2, hours_per_week: 2})
#subject5 = Subject.create({user:user, name: 'Физкультура', level:2, hours_per_week: 3})
#subject6 = Subject.create({user:user, name: 'Труд', level:2, hours_per_week: 1})
#
#teacher1 = Teacher.create({user:user, fio: 'Иванова И.И.'})
#teacher2 = Teacher.create({user:user, fio: 'Петрова П.П.'})
#
#KlassSubjectRelation.create({klass: klass1, subject:subject1, hours_per_week:2})
#KlassSubjectRelation.create({klass: klass1, subject:subject2, hours_per_week:4})
#KlassSubjectRelation.create({klass: klass1, subject:subject3, hours_per_week:2})
#KlassSubjectRelation.create({klass: klass1, subject:subject4, hours_per_week:2})
#KlassSubjectRelation.create({klass: klass1, subject:subject5, hours_per_week:3})
#KlassSubjectRelation.create({klass: klass1, subject:subject6, hours_per_week:1})
#KlassSubjectRelation.create({klass: klass2, subject:subject1, hours_per_week:2})
#KlassSubjectRelation.create({klass: klass2, subject:subject2, hours_per_week:4})
#KlassSubjectRelation.create({klass: klass2, subject:subject3, hours_per_week:2})
#KlassSubjectRelation.create({klass: klass2, subject:subject4, hours_per_week:2})
#KlassSubjectRelation.create({klass: klass2, subject:subject5, hours_per_week:3})
#KlassSubjectRelation.create({klass: klass2, subject:subject6, hours_per_week:1})
#
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject1})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject2})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject3})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject4})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject5})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject6})
#TeacherSubjectRelation.create({teacher: teacher2,subject:subject1})
#TeacherSubjectRelation.create({teacher: teacher2,subject:subject2})
#TeacherSubjectRelation.create({teacher: teacher2,subject:subject3})
#TeacherSubjectRelation.create({teacher: teacher2,subject:subject4})
#TeacherSubjectRelation.create({teacher: teacher2,subject:subject5})
#TeacherSubjectRelation.create({teacher: teacher2,subject:subject6})
#
#TeacherRoomRelation.create({teacher:teacher1, room: room1})
#TeacherRoomRelation.create({teacher:teacher1, room: room3})
#TeacherRoomRelation.create({teacher:teacher1, room: room4})
#TeacherRoomRelation.create({teacher:teacher2, room: room2})
#TeacherRoomRelation.create({teacher:teacher2, room: room3})
#TeacherRoomRelation.create({teacher:teacher2, room: room4})
#
#SubjectRoomRelation.create({subject: subject5, room:room4})
#SubjectRoomRelation.create({subject: subject6, room:room3})
#SubjectRoomRelation.create({subject: subject5, room:room4})
#SubjectRoomRelation.create({subject: subject6, room:room3})
#
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject1})
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject2})
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject3})
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject4})
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject5})
#TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject1})
#TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject2})
#TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject3})
#TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject4})
#TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject5})
#
## Урок труда ведут в другом кабинете перекрестно
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass2, subject:subject6})
#TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass1, subject:subject6})

#version 2

#room1 = Room.create({user:user, name: '2а начальные классы', number:'201'})
#
#klass1 = Klass.create({user:user, name: '2a', level:2, days_per_week: 1, lessons_per_day: 3})
#
#subject1 = Subject.create({user:user, name: 'Чтение', level:2, hours_per_week: 1})
#subject2 = Subject.create({user:user, name: 'Рисование', level:2, hours_per_week: 1})
#subject3 = Subject.create({user:user, name: 'Пение', level:2, hours_per_week: 1})
#
#teacher1 = Teacher.create({user:user, fio: 'Иванова И.И.'})
#
#KlassSubjectRelation.create({klass: klass1, subject:subject1, hours_per_week:1})
#KlassSubjectRelation.create({klass: klass1, subject:subject2, hours_per_week:1})
#KlassSubjectRelation.create({klass: klass1, subject:subject3, hours_per_week:1})
#
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject1})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject2})
#TeacherSubjectRelation.create({teacher: teacher1,subject:subject3})
#
#TeacherRoomRelation.create({teacher:teacher1, room: room1})
#
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject1})
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject2})
#TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject3})

#version 3

room1 = Room.create({user:user, name: '2а начальные классы', number:'201'})
room2 = Room.create({user:user, name: '2б начальные классы', number:'202'})

klass1 = Klass.create({user:user, name: '2a', level:2, days_per_week: 1, lessons_per_day: 3})
klass2 = Klass.create({user:user, name: '2б', level:2, days_per_week: 1, lessons_per_day: 3})

subject1 = Subject.create({user:user, name: 'Чтение', level:2, hours_per_week: 1})
subject2 = Subject.create({user:user, name: 'Рисование', level:2, hours_per_week: 1})
subject3 = Subject.create({user:user, name: 'Пение', level:2, hours_per_week: 1})

teacher1 = Teacher.create({user:user, fio: 'Иванова И.И.'})
teacher2 = Teacher.create({user:user, fio: 'Сидорова С.С.'})

KlassSubjectRelation.create({klass: klass1, subject:subject1, hours_per_week:1})
KlassSubjectRelation.create({klass: klass1, subject:subject2, hours_per_week:1})
KlassSubjectRelation.create({klass: klass1, subject:subject3, hours_per_week:1})
KlassSubjectRelation.create({klass: klass2, subject:subject1, hours_per_week:1})
KlassSubjectRelation.create({klass: klass2, subject:subject2, hours_per_week:1})
KlassSubjectRelation.create({klass: klass2, subject:subject3, hours_per_week:1})


TeacherSubjectRelation.create({teacher: teacher1,subject:subject1})
TeacherSubjectRelation.create({teacher: teacher1,subject:subject2})
TeacherSubjectRelation.create({teacher: teacher1,subject:subject3})
TeacherSubjectRelation.create({teacher: teacher2,subject:subject1})
TeacherSubjectRelation.create({teacher: teacher2,subject:subject2})
TeacherSubjectRelation.create({teacher: teacher2,subject:subject3})


TeacherRoomRelation.create({teacher:teacher1, room: room1})
TeacherRoomRelation.create({teacher:teacher2, room: room2})

TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject1})
TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject2})
TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject3})
TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject1})
TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject2})
TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject3})



