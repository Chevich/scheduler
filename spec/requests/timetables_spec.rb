#coding: utf-8
require "spec_helper"

describe "Таблица списка сгенерированных расписаний", :type => :request do
  include Capybara::DSL

  before(:each) do
    @user = Fabricate(:user)
    visit('/')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('Sign in')
  end

  it "присутствует" do
    visit('/')
    click_on('Сгенерированные расписания')
    current_path.should == timetables_path
  end

end
