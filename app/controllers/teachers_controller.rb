class TeachersController < ApplicationController
  def index
    @teachers = current_user.teachers.all
  end

  def new
    @teacher = current_user.teachers.new
  end

  def create
    @teacher = current_user.teachers.new
    @teacher.fio = params[:teacher][:fio]
    @teacher.user = current_user
    @teacher.save!
    redirect_to teachers_path()
  end

  def edit
    @teacher = current_user.teachers.find(params[:id])
    render 'new'
  end

  def show
    redirect_to 'edit'
  end

  def update
    @teacher = current_user.teachers.find(params[:id])
    @teacher.fio = params[:teacher][:fio]
    @teacher.save!
    redirect_to teachers_path()
  end

  def destroy
    current_user.teachers.find(params[:id]).delete
    redirect_to teachers_path()
  end
end
