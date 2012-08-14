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
    @subject.save!
    redirect_to subjects_path()
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
    @subject.save!
    redirect_to subjects_path()
  end

  def destroy
    current_user.subjects.find(params[:id]).delete
    redirect_to subjects_path()
  end

end
