class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new
    @room.name = params[:room][:name]
    @room.number = params[:room][:number]
    @room.user = current_user
    @room.save!
    redirect_to rooms_path()
  end

  def show
    redirect_to 'edit'
  end

  def edit
    @room = current_user.rooms.find(params[:id])
    render 'new'
  end

  def update
    @room = current_user.rooms.find(params[:id])
    @room.name = params[:room][:name]
    @room.number = params[:room][:number]
    @room.save!
    redirect_to rooms_path()
  end

  def destroy
    current_user.rooms.find(params[:id]).delete
    redirect_to rooms_path()
  end

end

