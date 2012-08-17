#coding: utf-8
require "spec_helper"

describe RoomsController do
  include Capybara::DSL

  let(:room){Fabricate(:room)}

  before(:each) do
    sign_in Fabricate(:user)
  end


  it "INDEX успешен" do
    get :index
    response.should be_success
  end

  it "EDIT успешен" do
    get :edit, :id => room.id
    response.should be_success
  end

  it "UPDATE успешен" do
    put :update, :id => room.id, :room => {name: "another room", number:'414'}
    response.should redirect_to(rooms_path)
  end

  it "UPDATE делает правильные значения" do
    put :update, :id => room.id, :room => {name: "another room", number:'414'}
    room.reload
    room.name.should == "another room"
  end

  it "CREATE вставляет кабинет" do
    expect {post :create, :room =>  {name: "small room", number:'415'}}.to change(Room, :count)
  end


  it "DELETE удаляет кабинет" do
    room.touch
    expect {delete :destroy, :id => room.id}.to change(Room, :count)
  end

  it "Проверка валидаций NAME" do
    put :update, :id => room.id, :room => {name: "", number:'414'}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций NUMBER" do
    put :update, :id => room.id, :room => {name: "another room", number:''}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций на создании  NAME" do
    post :create, :room => {name: "", number:'414'}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций на создании NUMBER" do
    post :create, :room => {name: "another room", number:''}
    flash[:error].should_not be_nil
  end



end

