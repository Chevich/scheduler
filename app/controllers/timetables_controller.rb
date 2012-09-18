#coding: utf-8
class TimetablesController < ApplicationController
  def index
    @timetables = current_user.timetables.all
  end

  def recalculate
    message = Timetable.re_calculate(current_user)
    @timetables = current_user.timetables.all
    if @timetables.empty?
      flash[:notice] = "Нет возможных вариантов расчета (#{message})"
    else
      flash[:notice] = "Расчитано #{"первых" if @timetables.count==30} #{@timetables.count} вариантов расписания (#{message})"
    end
    render 'index'
  end

  def delete_all
    current_user.timetables.delete_all
    redirect_to timetables_path()
  end
end
