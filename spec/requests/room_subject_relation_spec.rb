#coding: utf-8
require "spec_helper"

describe "Связь предметов и кабинетов", :type => :request do
  include Capybara::DSL

  before(:each) do
    @user = Fabricate(:user)
    @room = Fabricate(:room)
    visit('/')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('Sign in')
  end

  it "присутствует" do
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    current_path.should == room_subject_relations_path
  end

  it "свяжем все предметы с кабинетом" do
    Fabricate(:subject, :name => 'Физкультура')
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Добавить все предметы')
    page.should have_content('Физкультура')
    page.should have_content('Пение')
  end

  it "свяжем один предмет с кабинетом" do
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Новый предмет')
    select 'Пение', :from => 'Предмет'
    click_on('Сохранить')
    page.should have_content('Пение')
  end

  it "удалим все предметы у кабинета" do
    Fabricate(:subject, :name => 'Физкультура')
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Добавить все предметы')
    click_on('Удалить все предметы')
    page.should have_content('Пустой список')
  end

  it "откажемся от ввода предмета" do
    Fabricate(:subject, :name => 'Физкультура')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Новый предмет')
    click_on('Назад')
    current_path.should == room_subject_relations_path
  end





end
