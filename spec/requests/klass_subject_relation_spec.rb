#coding: utf-8
require "spec_helper"

describe "Связь предметов и классов", :type => :request do
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
    click_on('Предметы')
    current_path.should == klass_subject_relations_path
  end

  it "свяжем все предметы с классом" do
    Fabricate(:subject, {name:'Физкультура',level:7})
    Fabricate(:subject, {name:'Пение',level:7})
    Fabricate(:subject, {name:'Астрономия',level:3})
    visit('/')
    click_on('Классы')
    click_on('Предметы')
    click_on('Добавить все предметы')
    page.should have_content('Физкультура')
    page.should have_content('Пение')
    page.should_not have_content('Астрономия')
  end

  it "свяжем один предмет с классом" do
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Классы')
    click_on('Предметы')
    click_on('Новый предмет')
    select 'Пение', :from => 'Предмет'
    fill_in 'Часов в неделю', :with => '5'
    click_on('Сохранить')
    page.should have_content('Пение')
  end

  it "удалим все предметы у класса" do
    Fabricate(:subject, :name => 'Физкультура')
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Классы')
    click_on('Предметы')
    click_on('Новый предмет')
    select 'Пение', :from => 'Предмет'
    fill_in 'Часов в неделю', :with => '5'
    click_on('Сохранить')
    click_on('Удалить все предметы')
    page.should have_content('Пустой список')
  end

  it "откажемся от ввода предмета" do
    Fabricate(:subject, :name => 'Физкультура')
    visit('/')
    click_on('Классы')
    click_on('Предметы')
    click_on('Новый предмет')
    click_on('Назад')
    current_path.should == klass_subject_relations_path
  end
end
