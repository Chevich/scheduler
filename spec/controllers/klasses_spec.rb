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
    response.should redirect_to(klasses_path)
  end

  it "UPDATE делает правильные значения" do
    put :update, :id => klass.id, :klass => {name: "another klass", level: 7}
    klass.reload
    klass.name.should == "another klass"
  end

  it "CREATE вставляет предмет" do
    expect {post :create, :klass =>  {name: "small klass", level: 7}}.to change(Klass, :count)
  end


  it "DELETE удаляет предмет" do
    klass.touch
    expect {delete :destroy, :id => klass.id}.to change(Klass, :count)
  end

end

