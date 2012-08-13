class RoomSubjectRelationsController < ApplicationController
  def index
    @room = Room.find(params[:rooms_id]) unless params[:rooms_id].nil?
    @room_subject_relations = RoomSubjectRelation.where("room_id = ?", @room.id)
  end

  def new
    @room_subject_relations = RoomSubjectRelation.new
    @room_subject_relations.room_id = params[:rooms_id] unless params[:rooms_id].nil?
  end

  def add_all
    unless params[:rooms_id].nil?
      room = Room.find(params[:rooms_id])
      room.subjects << Subject.all
      room.save!
      redirect_to room_subject_relations_path(:params => {rooms_id:room.id}) and return
    end
    redirect_to room_subject_relations_path()
  end

  def delete_all
    unless params[:rooms_id].nil?
      room = Room.find(params[:rooms_id])
      room.subjects.clear
      room.save!
      redirect_to room_subject_relations_path(:params => {rooms_id:room.id}) and return
    end
    redirect_to room_subject_relations_path()
  end

  def create
    @room_subject_relations = RoomSubjectRelation.new
    @room_subject_relations.room_id = params[:room_subject_relation][:room_id] unless params[:room_subject_relation][:room_id].nil?
    @room_subject_relations.subject_id = params[:room_subject_relation][:subject] unless params[:room_subject_relation][:subject].nil?
    @room_subject_relations.save!
    puts '********** ' + @room_subject_relations.inspect
    redirect_to room_subject_relations_path(:params => {rooms_id:params[:room_subject_relation][:room_id]}) and return
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy

    subj = RoomSubjectRelation.find(params[:id])
    room = subj.room
    subj.delete
    redirect_to room_subject_relations_path(:params => {rooms_id:room.id})
  end
end
