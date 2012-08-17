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
    hash = Timetable.re_calculate(current_user)
    @html = hash.inspect
    render 'index'
  end
end
