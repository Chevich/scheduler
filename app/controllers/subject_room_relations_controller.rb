class SubjectRoomRelationsController < ApplicationController
  def index
    @subject = current_user.subjects.find(params[:subjects_id]) unless params[:subjects_id].nil?
    @subject_room_relations = SubjectRoomRelation.where("subject_id = ?", @subject.id)
  end

  def new
    @subject_room_relations = SubjectRoomRelation.new
    @subject_room_relations.subject_id = params[:subjects_id] unless params[:subjects_id].nil?
  end

  def add_all
    unless params[:subjects_id].nil?
      subject = current_user.subjects.find(params[:subjects_id])
      subject.rooms << Room.all
      subject.save!
      redirect_to subject_room_relations_path(:params => {subjects_id:subject.id}) and return
    end
    redirect_to subject_room_relations_path()
  end

  def delete_all
    unless params[:subjects_id].nil?
      subject = current_user.subjects.find(params[:subjects_id])
      subject.rooms.clear
      subject.save!
      redirect_to subject_room_relations_path(:params => {subjects_id:subject.id}) and return
    end
    redirect_to subject_room_relations_path()
  end

  def create
    @subject_room_relations = SubjectRoomRelation.new
    @subject_room_relations.subject_id = params[:subject_room_relation][:subject_id] unless params[:subject_room_relation][:subject_id].nil?
    @subject_room_relations.room_id = params[:subject_room_relation][:room] unless params[:subject_room_relation][:room].nil?
    @subject_room_relations.save!
    redirect_to subject_room_relations_path(:params => {subjects_id:params[:subject_room_relation][:subject_id]})
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy

    subj = SubjectRoomRelation.find(params[:id])
    subject = subj.subject
    subj.delete
    redirect_to subject_room_relations_path(:params => {subjects_id:subject.id})
  end
end
