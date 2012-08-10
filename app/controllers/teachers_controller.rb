class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new
    @teacher.fio = params[:teacher][:fio]
    @teacher.save!
    redirect_to teachers_path()
  end

  def edit
    @teacher = Teacher.find(params[:id])
    render 'new'
  end

  def show
    redirect_to 'edit'
  end

  def update
    @teacher = Teacher.find(params[:id])
    @teacher.fio = params[:teacher][:fio]
    @teacher.save!
    redirect_to teachers_path()
  end

  def destroy
    Teacher.find(params[:id]).delete
    redirect_to teachers_path()
  end
end
