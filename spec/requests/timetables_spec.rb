#coding: utf-8
require "spec_helper"

describe "Таблица списка сгенерированных расписаний", :type => :request do
  include Capybara::DSL

  describe '1 кабинет, 1 класс, 1 Учитель, 3 Предмета, 1(3) день' do
    before(:each) do
      @user = Fabricate(:user)
      visit('/')
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on('Sign in')

      # вводим начальные тестовые данные
      room1 = Fabricate(:room, {name: '2а начальные классы', number:'201'})

      klass1 = Fabricate(:klass,{name: '2a', level:2, days_per_week: 1, lessons_per_day: 3, days: '1'})

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

    it "присутствует" do
      click_on('Сгенерированные расписания')
      current_path.should == timetables_path
    end

    it "имеет возможность пересчитать расписание" do
      click_on('Сгенерированные расписания')
      click_on('Пересчитать расписания')
      current_path.should == timetables_path
    end

    it "выдает правильное флеш-сообщение" do
      click_on('Сгенерированные расписания')
      click_on('Пересчитать расписания')
      page.should have_selector('div#notice')
    end

    it "имеет возможность очищаться" do
      click_on('Сгенерированные расписания')
      click_on('Пересчитать расписания')
      click_on('Очистить список')
      current_path.should == timetables_path
    end
  end
end
