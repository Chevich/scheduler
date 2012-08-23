#coding: utf-8
require "spec_helper"

describe "модель Классы", :type => :request do
  include Capybara::DSL

  before(:each) do
    @user = Fabricate(:user)
    @klass = Fabricate(:klass, {level:7})
    visit('/')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('Sign in')
  end

  it "присутствует" do
    visit('/')
    click_on('Классы')
    current_path.should == klasses_path
  end

  it "Есть поля 'Уроков в день' и 'Учебных дней в неделю'" do
    visit('/')
    click_on('Классы')
    page.should have_content('Уроков в день')
    page.should have_content('Учебных дней в неделю')
  end

  it "Есть поля 'Уроков в день' и 'Учебных дней в неделю'" do
    visit('/')
    click_on('Классы')
    click_on('Изменить')
    fill_in 'Уроков в день', :with => '2'
    fill_in 'Учебных дней в неделю', :with => '8'
    click_on('Сохранить')
    current_path.should == klasses_path
  end


end
