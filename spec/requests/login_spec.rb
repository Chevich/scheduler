#coding: utf-8
require "spec_helper"

describe "Проверка авторизации", :type => :request do
  include Capybara::DSL

  it "При первом заходе должен попасть на страничку ввода пароля" do
    visit('/')
    current_path.should == new_user_session_path
  end

  context "При введенном правильно пароле" do
    before(:each) do
      @user = Fabricate(:user)
      visit('/')
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on('Sign in')
    end

    it "попадает на начальную страничку" do
      current_path.should == root_path
    end

    it "нажимаем на выход и попадаем в окно логина" do
      click_on('Выйти')
      current_path.should == new_user_session_path
    end
  end

end
