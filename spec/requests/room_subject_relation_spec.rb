#coding: utf-8
require "spec_helper"

describe "Форма создания зависимостей", :type => :request do
  include Capybara::DSL

  before(:each) do
    @room = Fabricate(:room)
    @user = Fabricate(:user)
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

  it "свяжем все предметы и кабинет" do
    Fabricate(:subject, :name => 'Физкультура')
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Добавить все предметы')
    page.should have_content('Физкультура')
    page.should have_content('Пение')
  end

  it "свяжем один предмет и кабинет" do
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Новый предмет')
    select 'Пение', :from => 'Предмет'
    click_on('Сохранить')
    page.should have_content('Пение')
  end

  it "удалим все предметы и кабинет" do
    Fabricate(:subject, :name => 'Физкультура')
    Fabricate(:subject, :name => 'Пение')
    visit('/')
    click_on('Кабинеты')
    click_on('Предметы')
    click_on('Добавить все предметы')
    click_on('Удалить все предметы')
    page.should have_content('Пустой список')
  end




end
