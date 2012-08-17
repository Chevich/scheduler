#coding: utf-8
require "spec_helper"

describe TeachersController do
  include Capybara::DSL

  let(:teacher){Fabricate(:teacher)}

  before(:each) do
    sign_in Fabricate(:user)
  end


  it "INDEX успешен" do
    get :index
    response.should be_success
  end

  it "EDIT успешен" do
    get :edit, :id => teacher.id
    response.should be_success
  end

  it "UPDATE успешен" do
    put :update, :id => teacher.id, :teacher => {fio: "another teacher"}
    response.should redirect_to(teachers_path)
  end

  it "UPDATE делает правильные значения" do
    put :update, :id => teacher.id, :teacher => {fio: "another teacher"}
    teacher.reload
    teacher.fio.should == "another teacher"
  end

  it "CREATE вставляет предмет" do
    expect {post :create, :teacher =>  {fio: "small teacher"}}.to change(Teacher, :count)
  end


  it "DELETE удаляет предмет" do
    teacher.touch
    expect {delete :destroy, :id => teacher.id}.to change(Teacher, :count)
  end

  it "Проверка валидаций FIO" do
    put :update, :id => teacher.id, :teacher => {fio: ""}
    flash[:error].should_not be_nil
  end


  it "Проверка валидаций (на создании) FIO" do
    post :create, :teacher =>  {fio: ""}
    flash[:error].should_not be_nil
  end


end

