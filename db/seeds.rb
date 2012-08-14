#coding: utf-8

user = User.create({:email => 'andy.chevich@gmail.com', :password => 'andy123'})

Room.create({user:user, name: 'Математика', number:'101'})
Room.create({user:user, name: 'География', number:'102'})
Room.create({user:user, name: 'Астрономия', number:'103'})
Room.create({user:user, name: 'Русский язык', number:'104'})

Klass.create({user:user, name: '2a', level:2})
Klass.create({user:user, name: '3a', level:3})
Klass.create({user:user, name: '2б', level:2})
Klass.create({user:user, name: '3б', level:3})

Subject.create({user:user, name: 'Математика', level:2, hours_per_week: 2})
Subject.create({user:user, name: 'Геометрия', level:7, hours_per_week: 4})
Subject.create({user:user, name: 'Алгебра', level:7, hours_per_week: 2})
Subject.create({user:user, name: 'Чтение', level:2, hours_per_week: 2})
Subject.create({user:user, name: 'Рисование', level:2, hours_per_week: 2})
Subject.create({user:user, name: 'Пение', level:2, hours_per_week: 2})
Subject.create({user:user, name: 'Физкультура', level:2, hours_per_week: 2})
Subject.create({user:user, name: 'Астрономия', level:7, hours_per_week: 2})
Subject.create({user:user, name: 'НВП', level:9, hours_per_week: 2})

Teacher.create({user:user, fio: 'Иванова И.И.'})
Teacher.create({user:user, fio: 'Петрова П.П.'})
Teacher.create({user:user, fio: 'Сидорова С.С.'})
