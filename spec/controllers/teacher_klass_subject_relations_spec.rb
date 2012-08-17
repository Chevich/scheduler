#coding: utf-8
require "spec_helper"

describe TeacherKlassSubjectRelationsController do
  include Capybara::DSL
  before(:each) do
    sign_in Fabricate(:user)
    @teacher = Fabricate(:teacher)
    @klass = Fabricate(:klass)
    @subject = Fabricate(:subject)
  end

  it "Проверка валидаций на (все верно)" do
    post :create, :teacher_klass_subject_relation => {teacher_id: @teacher.id, subject:@subject.id, klass:@klass.id}
    flash[:error].should be_nil
  end

  it "Проверка валидаций TEACHER" do
    post :create, :teacher_klass_subject_relation => {subject:@subject.id, klass:@klass.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций KLASS" do
    post :create, :teacher_klass_subject_relation => {subject:@subject.id, teacher_id: @teacher.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций SUBJECT" do
    post :create, :teacher_klass_subject_relation => {teacher_id: @teacher.id, klass:@klass.id}
    flash[:error].should_not be_nil
  end

  it "Проверка валидаций уникальности" do
    Fabricate(:teacher_klass_subject_relation, {teacher:@teacher, subject:@subject, klass:@klass})
    post :create, :teacher_klass_subject_relation => {teacher_id: @teacher.id, subject:@subject.id, klass:@klass.id}
    flash[:error].should_not be_nil
  end

end

