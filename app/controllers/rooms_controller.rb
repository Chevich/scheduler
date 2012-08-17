#coding: utf-8
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
    if @room.save
      flash[:success] = "Кабинет изменен."
      redirect_to rooms_path()
    else
      flash[:error] = @room.errors.full_messages
      render 'new'
    end
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
    if @room.save
      flash[:success] = "Кабинет изменен."
      redirect_to rooms_path()
    else
      flash[:error] = @room.errors.full_messages
      render 'new'
    end
  end

  def destroy
    current_user.rooms.find(params[:id]).delete
    redirect_to rooms_path()
  end

end

