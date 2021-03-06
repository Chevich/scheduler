#coding: utf-8
class KlassesController < ApplicationController
  def index
    @klasses = current_user.klasses.all
  end

  def new
    @klass = current_user.klasses.new
  end

  def create
    @klass = current_user.klasses.new
    @klass.update_attributes(params[:klass])
    @klass.user = current_user
    if @klass.save
      flash[:success] = "Класс изменен."
      redirect_to klasses_path()
    else
      flash[:error] = @klass.errors.full_messages
      render 'new'
    end
  end

  def edit
    @klass = current_user.klasses.find(params[:id])
    render 'new'
  end

  def show
    redirect_to 'edit'
  end


  def update
    @klass = current_user.klasses.find(params[:id])
    @klass.name = params[:klass][:name]
    @klass.level = params[:klass][:level]
    @klass.lessons_per_day = params[:klass][:lessons_per_day]
    @klass.days_per_week = params[:klass][:days_per_week]
    @klass.days = params[:klass][:days]
    if @klass.save
      flash[:success] = "Класс изменен."
      redirect_to klasses_path()
    else
      flash[:error] = @klass.errors.full_messages
      render 'new'
    end
  end

  def destroy
    Klass.find(params[:id]).delete
    redirect_to klasses_path()
  end
end
