#coding: utf-8
class TimetablesController < ApplicationController
  def index
    @timetables = current_user.timetables.all
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
    redirect_to timetables_path()
  end

  def delete_all
    current_user.timetables.delete_all
    redirect_to timetables_path()
  end
end
