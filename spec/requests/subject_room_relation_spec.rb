#coding: utf-8
require "spec_helper"

describe "Связь кабинетов и предметов", :type => :request do
  include Capybara::DSL

  before(:each) do
    @user = Fabricate(:user)
    @subject = Fabricate(:subject)
    visit('/')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('Sign in')
  end

  it "присутствует" do
    visit('/')
    click_on('Предметы')
    click_on('Кабинеты')
    current_path.should == subject_room_relations_path
  end

  it "свяжем все кабинеты с предметом" do
    Fabricate(:room, :name => '400а', :number => '400а')
    Fabricate(:room, :name => '500а', :number => '500а')
    visit('/')
    click_on('Предметы')
    click_on('Кабинеты')
    click_on('Добавить все кабинеты')
    page.should have_content('400а')
    page.should have_content('500а')
  end

  it "свяжем один кабинет с предметом" do
    Fabricate(:room, :name => '400а', :number => '400а')
    visit('/')
    click_on('Предметы')
    click_on('Кабинеты')
    click_on('Новый кабинет')
    select '400а(400а)', :from => 'Кабинет'
    click_on('Сохранить')
    page.should have_content('400а')
  end

  it "удалим все кабинеты у предмета" do
    Fabricate(:room, :name => '400а', :number => '400а')
    Fabricate(:room, :name => '500а', :number => '500а')
    visit('/')
    click_on('Предметы')
    click_on('Кабинеты')
    click_on('Добавить все кабинеты')
    click_on('Удалить все кабинеты')
    page.should have_content('Пустой список')
  end

  it "откажемся от ввода кабинета" do
    Fabricate(:room, :name => '400а', :number => '400а')
    visit('/')
    click_on('Предметы')
    click_on('Кабинеты')
    click_on('Новый кабинет')
    click_on('Назад')
    current_path.should == subject_room_relations_path
  end





end
