#coding: utf-8
require "spec_helper"

describe KlassesController do
  include Capybara::DSL

  let(:klass){Fabricate(:klass)}

  before(:each) do
    sign_in Fabricate(:user)
  end


  it "INDEX успешен" do
    get :index
    response.should be_success
  end

  it "EDIT успешен" do
    get :edit, :id => klass.id
    response.should be_success
  end

  it "UPDATE успешен" do
    put :update, :id => klass.id, :klass => {name: "another klass", level: 7}
    flash[:error].should be_nil
    response.should redirect_to(klasses_path)
  end

  it "UPDATE делает правильные значения" do
    put :update, :id => klass.id, :klass => {name: "another klass", level: 7}
    klass.reload
    klass.name.should == "another klass"
  end

  it "CREATE вставляет предмет" do
    expect {post :create, :klass =>  {name: "small klass", level: 7, lessons_per_day: 5, days_per_week: 6}}.to change(Klass, :count)
  end


  it "DELETE удаляет предмет" do
    klass.touch
    expect {delete :destroy, :id => klass.id}.to change(Klass, :count)
  end

  it "Проверка валидаций NAME" do
    put :update, :id => klass.id, :klass => {name: "", level: 7}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций LEVEL" do
    put :update, :id => klass.id, :klass => {name: "another klass", level: -1}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций на создании NAME" do
    post :create, :klass => {name: "", level: 7}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций на создании LEVEL" do
    post :create, :klass => {name: "another klass", level: -1}
    flash[:error].should_not be_nil
  end

end

