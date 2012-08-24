#coding: utf-8
require 'spec_helper'

describe Timetable do

  before(:each) do
    @user = Fabricate(:user)
    #sign_in @user
    # вводим начальные тестовые данные
    room1 = Fabricate(:room, {name: '2а начальные классы', number:'201'})

    klass1 = Fabricate(:klass,{name: '2a', level:2, days_per_week: 1, lessons_per_day: 3})

    subject1 = Fabricate(:subject,{name: 'Чтение', level:2, hours_per_week: 1})
    subject2 = Fabricate(:subject,{name: 'Рисование', level:2, hours_per_week: 1})
    subject3 = Fabricate(:subject,{name: 'Пение', level:2, hours_per_week: 1})

    teacher1 = Fabricate(:teacher,{fio: 'Иванова И.И.'})

    Fabricate(:klass_subject_relation,{klass: klass1, subject:subject1, hours_per_week:1})
    Fabricate(:klass_subject_relation,{klass: klass1, subject:subject2, hours_per_week:1})
    Fabricate(:klass_subject_relation,{klass: klass1, subject:subject3, hours_per_week:1})

    Fabricate(:teacher_subject_relation,{teacher: teacher1,subject:subject1})
    Fabricate(:teacher_subject_relation,{teacher: teacher1,subject:subject2})
    Fabricate(:teacher_subject_relation,{teacher: teacher1,subject:subject3})

    Fabricate(:teacher_room_relation,{teacher:teacher1, room: room1})

    Fabricate(:teacher_klass_subject_relation,{teacher:teacher1, klass: klass1, subject:subject1})
    Fabricate(:teacher_klass_subject_relation,{teacher:teacher1, klass: klass1, subject:subject2})
    Fabricate(:teacher_klass_subject_relation,{teacher:teacher1, klass: klass1, subject:subject3})

  end

  describe "Новый кабинет должен иметь все предметы по-умолчанию" do
    it "когда нет предметов - в списке пусто" do
      Timetable.re_calculate(@user)
      Timetable.count.should == 6
      TimetablesDtl.count.should == 6 * 3
    end
  end
end