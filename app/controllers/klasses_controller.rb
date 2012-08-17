#coding: utf-8
class KlassesController < ApplicationController
  def index
    add_breadcrumb "klass", klasses_path()
    @klasses = current_user.klasses.all
  end

  def new
    @klass = current_user.klasses.new
  end

  def create
    @klass = current_user.klasses.new
    @klass.name = params[:klass][:name]
    @klass.level = params[:klass][:level]
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
