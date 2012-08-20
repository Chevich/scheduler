#coding: utf-8
class TimetablesController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def recalculate
    array = Timetable.re_calculate(current_user)
    @timeline_array = array
    render 'index'
  end
end
