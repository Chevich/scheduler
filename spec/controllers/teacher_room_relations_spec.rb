#coding: utf-8
require "spec_helper"

describe TeacherRoomRelationsController do
  include Capybara::DSL
  before(:each) do
    sign_in Fabricate(:user)
    @room = Fabricate(:room)
    @teacher = Fabricate(:teacher)
  end

  it "Проверка валидаций (все верно)" do
    post :create, :teacher_room_relation => {room: @room.id, teacher_id:@teacher.id}
    flash[:error].should be_nil
  end

  it "Проверка валидаций ROOM" do
    post :create, :teacher_room_relation => {teacher_id:@teacher.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций TEACHER" do
    post :create, :teacher_room_relation => {room: @room.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций уникальности" do
    Fabricate(:teacher_room_relation, {room:@room, teacher:@teacher})
    post :create, :teacher_room_relation => {room: @room.id, teacher_id:@teacher.id}
    flash[:error].should_not be_nil
  end

end

