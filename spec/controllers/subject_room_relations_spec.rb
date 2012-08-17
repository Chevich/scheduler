#coding: utf-8
require "spec_helper"

describe SubjectRoomRelationsController do
  include Capybara::DSL
  before(:each) do
    sign_in Fabricate(:user)
    @room = Fabricate(:room)
    @subject = Fabricate(:subject)
  end

  it "Проверка валидаций (все верно)" do
    post :create, :subject_room_relation => {room: @room.id, subject_id:@subject.id}
    flash[:error].should be_nil
  end

  it "Проверка валидаций ROOM" do
    post :create, :subject_room_relation => {subject_id:@subject.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций SUBJECT" do
    post :create, :subject_room_relation => {room: @room.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций уникальности" do
    Fabricate(:subject_room_relation, {room:@room, subject:@subject})
    post :create, :subject_room_relation => {room: @room.id, subject_id:@subject.id}
    flash[:error].should_not be_nil
  end

end

