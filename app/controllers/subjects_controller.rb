#coding: utf-8
class SubjectsController < ApplicationController
  def index
    @subjects = current_user.subjects.all
  end

  def new
    @subject = current_user.subjects.new
  end

  def create
    @subject = current_user.subjects.new
    @subject.name = params[:subject][:name]
    @subject.level = params[:subject][:level]
    @subject.hours_per_week = params[:subject][:hours_per_week]
    @subject.user = current_user
    if @subject.save
      flash[:success] = "Предмет изменен."
      redirect_to subjects_path()
    else
      flash[:error] = @subject.errors.full_messages
      render 'new'
    end
  end

  def edit
    @subject = current_user.subjects.find(params[:id])
    render 'new'
  end

  def show
    redirect_to 'edit'
  end


  def update
    @subject = current_user.subjects.find(params[:id])
    @subject.name = params[:subject][:name]
    @subject.level = params[:subject][:level]
    @subject.hours_per_week = params[:subject][:hours_per_week]
    if @subject.save
      flash[:success] = "Предмет изменен."
      redirect_to subjects_path()
    else
      flash[:error] = @subject.errors.full_messages
      render 'new'
    end
  end

  def destroy
    current_user.subjects.find(params[:id]).delete
    redirect_to subjects_path()
  end

end
