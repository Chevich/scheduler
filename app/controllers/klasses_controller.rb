class KlassesController < ApplicationController
  def index
    @klasses = Klass.all
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new
    @klass.name = params[:klass][:name]
    @klass.level = params[:klass][:level]
    @klass.save!
    redirect_to klasses_path()
  end

  def edit
    @klass = Klass.find(params[:id])
    render 'new'
  end

  def show
    redirect_to 'edit'
  end


  def update
    @klass = Klass.find(params[:id])
    @klass.name = params[:klass][:name]
    @klass.level = params[:klass][:level]
    @klass.save!
    redirect_to klasses_path()
  end

  def destroy
    Klass.find(params[:id]).delete
    redirect_to klasses_path()
  end
end
