#coding: utf-8
require "spec_helper"

describe SubjectsController do
  include Capybara::DSL

  let(:subject){Fabricate(:subject)}

  before(:each) do
    sign_in Fabricate(:user)
  end


  it "INDEX успешен" do
    get :index
    response.should be_success
  end

  it "EDIT успешен" do
    get :edit, :id => subject.id
    response.should be_success
  end

  it "UPDATE успешен" do
    put :update, :id => subject.id, :subject => {name: "another subject", level:4, hours_per_week: 4}
    response.should redirect_to(subjects_path)
  end

  it "UPDATE делает правильные значения" do
    put :update, :id => subject.id, :subject => {name: "another subject", level:4, hours_per_week: 4}
    subject.reload
    subject.name.should == "another subject"
  end

  it "CREATE вставляет предмет" do
    expect {post :create, :subject =>  {name: "small subject", level:4, hours_per_week: 4}}.to change(Subject, :count)
  end


  it "DELETE удаляет предмет" do
    subject.touch
    expect {delete :destroy, :id => subject.id}.to change(Subject, :count)
  end

end

