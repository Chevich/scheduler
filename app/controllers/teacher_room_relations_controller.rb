class TeacherRoomRelationsController < ApplicationController
  def index
    @teacher = current_user.teachers.find(params[:teachers_id]) unless params[:teachers_id].nil?
    @teacher_room_relations = TeacherRoomRelation.where("teacher_id = ?", @teacher.id)
  end

  def new
    @teacher_room_relations = TeacherRoomRelation.new
    @teacher_room_relations.teacher_id = params[:teachers_id] unless params[:teachers_id].nil?
  end

  def add_all
    unless params[:teachers_id].nil?
      teacher = current_user.teachers.find(params[:teachers_id])
      teacher.rooms << Room.all
      teacher.save!
      redirect_to teacher_room_relations_path(:params => {teachers_id:teacher.id}) and return
    end
    redirect_to teacher_room_relations_path()
  end

  def delete_all
    unless params[:teachers_id].nil?
      teacher = current_user.teachers.find(params[:teachers_id])
      teacher.rooms.clear
      teacher.save!
      redirect_to teacher_room_relations_path(:params => {teachers_id:teacher.id}) and return
    end
    redirect_to teacher_room_relations_path()
  end

  def create
    @teacher_room_relations = TeacherRoomRelation.new
    @teacher_room_relations.teacher_id = params[:teacher_room_relation][:teacher_id] unless params[:teacher_room_relation][:teacher_id].nil?
    @teacher_room_relations.room_id = params[:teacher_room_relation][:room] unless params[:teacher_room_relation][:room].nil?
    @teacher_room_relations.save!
    redirect_to teacher_room_relations_path(:params => {teachers_id:params[:teacher_room_relation][:teacher_id]})
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy

    subj = TeacherRoomRelation.find(params[:id])
    teacher = subj.teacher
    subj.delete
    redirect_to teacher_room_relations_path(:params => {teachers_id:teacher.id})
  end
end
