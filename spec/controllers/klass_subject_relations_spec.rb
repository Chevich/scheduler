#coding: utf-8
require "spec_helper"

describe KlassSubjectRelationsController do
  include Capybara::DSL
  before(:each) do
    sign_in Fabricate(:user)
    @klass = Fabricate(:klass) # 7 класс
    @subject1 = Fabricate(:subject) #4 класс
    @subject2 = Fabricate(:subject,{level:7,hours_per_week:12}) #7 класс
    @subject3 = Fabricate(:subject,{name:'Геометрия',level:7,hours_per_week:12}) #7 класс
  end

  it "INDEX успешен" do
    get :index, klasses_id:@klass.id
    response.should be_success
  end

  it "при добавлении ВСЕХ предметов добавляет 2 из 3 (только 7 класс)" do
    post :add_all, klasses_id:@klass.id
    KlassSubjectRelation.where("klass_id = ?",@klass.id).count.should == 2
  end

  it "при добавлении ВСЕХ предметов правильно добавляет количество часов в неделю" do
    post :add_all, klasses_id:@klass.id
    KlassSubjectRelation.where("klass_id = ?",@klass.id).each do |relation|
      relation.hours_per_week.should be(12)
    end
  end


end

