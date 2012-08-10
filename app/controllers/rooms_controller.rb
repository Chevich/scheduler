class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new
    @room.name = params[:room][:name]
    @room.number = params[:room][:number]
    @room.save!
    redirect_to rooms_path()
  end

  def show
    redirect_to 'edit'
  end

  def edit
    @room = Room.find(params[:id])
    render 'new'
  end

  def update
    @room = Room.find(params[:id])
    @room.name = params[:room][:name]
    @room.number = params[:room][:number]
    @room.save!
    redirect_to rooms_path()
  end

  def destroy
    Room.find(params[:id]).delete
    redirect_to rooms_path()
  end

end

