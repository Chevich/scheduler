#coding: utf-8
require 'spec_helper'

describe Timetable do
  describe 'variant 1' do
    before(:each) do
      @user = Fabricate(:user)
      #sign_in @user
      # вводим начальные тестовые данные
      @room1 = Fabricate(:room, {name: '2а начальные классы', number:'201'})
      @room_work = Fabricate(:room, {name: 'Кабинет труда', number:'101'})

      @klass1 = Fabricate(:klass,{name: '2a', level:2, days_per_week: 1, lessons_per_day: 4, days: '1'})

      @subject1 = Fabricate(:subject,{name: 'Чтение', level:2, hours_per_week: 1})
      @subject2 = Fabricate(:subject,{name: 'Рисование', level:2, hours_per_week: 1})
      @subject_work = Fabricate(:subject,{name: 'Труд', level:2, hours_per_week: 2})


      @teacher1 = Fabricate(:teacher,{fio: 'Иванова И.И.'})

      Fabricate(:klass_subject_relation,{klass: @klass1, subject:@subject1, hours_per_week:1})
      Fabricate(:klass_subject_relation,{klass: @klass1, subject:@subject2, hours_per_week:1})
      Fabricate(:klass_subject_relation,{klass: @klass1, subject:@subject_work, hours_per_week:1})

      Fabricate(:teacher_room_relation,{teacher:@teacher1, room: @room1})

      Fabricate(:subject_room_relation, {subject: @subject_work, room: @room_work})

      Fabricate(:teacher_klass_subject_relation,{teacher:@teacher1, klass: @klass1, subject:@subject1})
      Fabricate(:teacher_klass_subject_relation,{teacher:@teacher1, klass: @klass1, subject:@subject2})
      Fabricate(:teacher_klass_subject_relation,{teacher:@teacher1, klass: @klass1, subject:@subject_work})
    end

    it "в списке пусто" do
      Timetable.count.should == 0
    end

    it "не должно быть в разных расписаниях полностью одинаковых дней" do
      Timetable.re_calculate(@user)
      #pending
      @user.timetables.each_with_index do |tt1, index1|
        @user.timetables.each_with_index do |tt2, index2|
          if index2 > index1
            (tt1.to_hash - tt2.to_hash).should_not be_empty
          end
        end
      end
    end

    describe 'наращиваем расчет' do
      before(:each) do
        Timetable.re_calculate(@user)
      end

      it "можно расчитать вариант №1" do
        Timetable.count.should > 0
      end

      describe 'добавим класс в тот же кабинет (вариант №2)' do
        before(:each) do
          @klass2 = Fabricate(:klass,{name: '2б', level:2, days_per_week: 1, lessons_per_day: 3, days:'2,4'})

          Fabricate(:klass_subject_relation,{klass: @klass2, subject:@subject1, hours_per_week:1})
          Fabricate(:klass_subject_relation,{klass: @klass2, subject:@subject2, hours_per_week:1})
          Fabricate(:klass_subject_relation,{klass: @klass2, subject:@subject_work, hours_per_week:1})

          Fabricate(:teacher_klass_subject_relation,{teacher:@teacher1, klass: @klass2, subject:@subject1})
          Fabricate(:teacher_klass_subject_relation,{teacher:@teacher1, klass: @klass2, subject:@subject2})
          Fabricate(:teacher_klass_subject_relation,{teacher:@teacher1, klass: @klass2, subject:@subject_work})
        end

        describe 'после расчета проверяем 'do
          before(:each) do
            # Ищем
            Timetable.re_calculate(@user)
          end
          it "можно расчитать вариант №2" do
            Timetable.count.should > 0
          end
          it "1-й класс учится только в пондельник, а 2-й во вторник или четверг" do
            @user.timetables.each do |tt|
              tt.timetables_dtls.where('klass_id = ? and day <> ?',@klass1.id, 1).should be_empty
            end
            @user.timetables.each do |tt|
              tt.timetables_dtls.where('klass_id = ? and day <> ? and day <> ?',@klass2.id, 2, 4).should be_empty
            end
          end
        end

        describe 'Оба класса в один день' do
          before(:each) do
            @klass2.days = '1'
            Timetable.re_calculate(@user)
          end
          it 'учитель не может работать в двух классах одновременно' do
            @user.timetables.each do |tt|
              tt.timetables_dtls.select('count(*) as cnt').group(:teacher_id, :klass_id, :day, :lesson).having('count(*)>1').should be_empty
            end
          end
          it 'разные классы не могут использовать один кабинет одновременно' do
            @user.timetables.each do |tt|
              tt.timetables_dtls.select('count(*) as cnt').group(:klass_id, :room_id, :day, :lesson).having('count(*)>1').should be_empty
            end
          end
          it 'уроки труда проводятся только в кабинетах труда' do
            @user.timetables.each do |tt|
              tt.timetables_dtls.where('subject_id = ? and room_id<> ? ', @subject_work, @room_work).should be_empty
            end
          end
          it 'уроки (кроме труда) проводятся в кабинете учителя' do
            @user.timetables.each do |tt|
              tt.timetables_dtls.where('subject_id <> ? and teacher_id = ? and room_id = ? ', @subject_work, @teacher1, @room_work).should be_empty
              tt.timetables_dtls.where('subject_id <> ? and teacher_id = ? and room_id = ? ', @subject_work, @teacher1, @room1).should_not be_empty
            end
          end
        end
      end
    end
  end

  describe 'variant 2' do
    before(:each) do
      @user = Fabricate(:user)

      room1 = Room.create({user:@user, name: '2а начальные классы', number:'201'})
      room2 = Room.create({user:@user, name: '2б начальные классы', number:'202'})
      room3 = Room.create({user:@user, name: 'Труд', number:'101'})

      klass1 = Klass.create({user:@user, name: '2a', level:2, days_per_week: 1, lessons_per_day: 2, days:'1'})
      klass2 = Klass.create({user:@user, name: '2б', level:2, days_per_week: 1, lessons_per_day: 2, days:'2'})

      subject1 = Subject.create({user:@user, name: 'Чтение', level:2, hours_per_week: 1})
      subject6 = Subject.create({user:@user, name: 'Труд', level:2, hours_per_week: 1})

      teacher1 = Teacher.create({user:@user, fio: 'Иванова И.И.'})
      teacher2 = Teacher.create({user:@user, fio: 'Петрова П.П.'})

      KlassSubjectRelation.create({klass: klass1, subject:subject1, hours_per_week:1})
      KlassSubjectRelation.create({klass: klass1, subject:subject6, hours_per_week:1})

      KlassSubjectRelation.create({klass: klass2, subject:subject1, hours_per_week:1})
      KlassSubjectRelation.create({klass: klass2, subject:subject6, hours_per_week:1})

      TeacherSubjectRelation.create({teacher: teacher1,subject:subject1})
      TeacherSubjectRelation.create({teacher: teacher1,subject:subject6})

      TeacherSubjectRelation.create({teacher: teacher2,subject:subject1})
      TeacherSubjectRelation.create({teacher: teacher2,subject:subject6})

      TeacherRoomRelation.create({teacher:teacher1, room: room1})
      TeacherRoomRelation.create({teacher:teacher2, room: room2})

      SubjectRoomRelation.create({subject: subject6, room:room3})

      TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass1, subject:subject1})
      TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass2, subject:subject1})
      TeacherKlassSubjectRelation.create({teacher:teacher1, klass: klass2, subject:subject6})
      TeacherKlassSubjectRelation.create({teacher:teacher2, klass: klass1, subject:subject6})
    end

    it "не должно быть в разных расписаниях полностью одинаковых дней" do
      Timetable.re_calculate(@user)
      #pending
      @user.timetables.each_with_index do |tt1, index1|
        @user.timetables.each_with_index do |tt2, index2|
          if index2 > index1
            (tt1.to_hash - tt2.to_hash).should_not be_empty
          end
        end
      end
    end

  end


end

