#coding: utf-8
require "spec_helper"

describe "Проверка авторизации", :type => :request do
  include Capybara::DSL

  it "При первом заходе должен попасть на страничку ввода пароля" do
    visit('/')
    current_path.should == new_user_session_path
  end

  context "При введенном правильно пароле" do
    before(:each) do
      @user = Fabricate(:user)
      visit('/')
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on('Sign in')
    end

    it "попадает на начальную страничку" do
      current_path.should == root_path
    end

    it "нажимаем на выход и попадаем в окно логина" do
      click_on('Выйти')
      current_path.should == new_user_session_path
    end

    context "видим только свои записи в модели" do
      before(:each) do
        @another_user = Fabricate(:user, {email:"another@tut.by", password:"123123"})
      end
      it "Кабинеты" do
        Fabricate(:room, {user:@user, number:'401ы'})
        Fabricate(:room, {user:@user, number:'402ы'})
        Fabricate(:room, {user:@another_user, number:'403'})
        visit('/')
        click_on('Кабинеты')
        page.has_content?('401ы').should be_true
        page.has_content?('402ы').should be_true
        page.has_content?('403ы').should be_false
      end
      it "Учителя" do
        Fabricate(:teacher, {user:@user, fio:'Иванова'})
        Fabricate(:teacher, {user:@user, fio:'Сидорова'})
        Fabricate(:teacher, {user:@another_user, fio:'Забегайкин'})
        visit('/')
        click_on('Учителя')
        page.has_content?('Иванова').should be_true
        page.has_content?('Сидорова').should be_true
        page.has_content?('Забегайкин').should be_false
      end
      it "Предметы" do
        Fabricate(:subject, {user:@user, name:'Математика', level:7, hours_per_week:2})
        Fabricate(:subject, {user:@user, name:'Чтение', level:7, hours_per_week:2})
        Fabricate(:subject, {user:@another_user, name:'ФИЗКУЛЬТУРА', level:7, hours_per_week:2})
        visit('/')
        click_on('Предметы')
        page.has_content?('Математика').should be_true
        page.has_content?('Чтение').should be_true
        page.has_content?('ФИЗКУЛЬТУРА').should be_false
      end
      it "Классы" do
        Fabricate(:klass, {user:@user, name:'7a', level:7})
        Fabricate(:klass, {user:@user, name:'7б', level:7})
        Fabricate(:klass, {user:@another_user, name:'77', level:7})
        visit('/')
        click_on('Классы')
        page.has_content?('7a').should be_true
        page.has_content?('7б').should be_true
        page.has_content?('77').should be_false
      end

    end
  end

end
