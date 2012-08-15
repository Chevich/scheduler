#coding: utf-8
require "spec_helper"

describe "Связь классов и учителей (предметы!)", :type => :request do
  include Capybara::DSL

  before(:each) do
    @user = Fabricate(:user)
    @teacher = Fabricate(:teacher)
    visit('/')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('Sign in')
  end

  it "присутствует" do
    visit('/')
    click_on('Учителя')
    click_on('Классы')
    current_path.should == teacher_klass_subject_relations_path
  end

  it "свяжем все предметы с учителем" do
    subj1 = Fabricate(:subject, :name => 'Физкультура')
    subj2 = Fabricate(:subject, :name => 'Пение')
    Fabricate(:teacher_subject_relation, subject: subj1)
    Fabricate(:teacher_subject_relation, subject: subj2)
    klass = Fabricate(:klass, {name:'2а', level:2})
    Fabricate(:klass_subject_relation, {klass:klass, subject: subj1})
    Fabricate(:klass_subject_relation, {klass:klass, subject: subj2})
    visit('/')
    click_on('Учителя')
    click_on('Классы')
    click_on('Добавить все классы')
    page.should have_content('Физкультура')
    page.should have_content('Пение')
  end

  it "свяжем один класс с учителем" do
    Fabricate(:klass, :name => '7а')
    Fabricate(:subject, :name => 'Математика')
    visit('/')
    click_on('Учителя')
    click_on('Классы')
    click_on('Новый класс')
    select '7а', :from => 'Класс'
    select 'Математика', :from => 'Предмет'
    click_on('Сохранить')
    page.should have_content('7а')
    page.should have_content('Математика')
  end

  it "удалим все классы у учителя" do
    Fabricate(:klass, :name => '7а')
    Fabricate(:subject, :name => 'Математика')
    visit('/')
    click_on('Учителя')
    click_on('Классы')
    click_on('Новый класс')
    select '7а', :from => 'Класс'
    select 'Математика', :from => 'Предмет'
    click_on('Сохранить')
    click_on('Удалить все классы')
    page.should have_content('Пустой список')
  end

  it "откажемся от ввода предмета" do
    Fabricate(:klass, :name => '7а')
    visit('/')
    click_on('Учителя')
    click_on('Классы')
    click_on('Новый класс')
    click_on('Назад')
    current_path.should == teacher_klass_subject_relations_path
  end





end
