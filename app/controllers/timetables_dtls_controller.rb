#coding: utf-8
class TimetablesDtlsController < ApplicationController
  def index
    @dtls = TimetablesDtl.where("timetable_id = ?", params[:timetable_id]).order(:klass_id, :day, :lesson)
    @klasses = current_user.klasses.all
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
end
