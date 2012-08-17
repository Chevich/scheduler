class TeacherSubjectRelationsController < ApplicationController
  def index
    @teacher = current_user.teachers.find(params[:teachers_id]) unless params[:teachers_id].nil?
    @teacher_subject_relations = TeacherSubjectRelation.where("teacher_id = ?", @teacher.id)
  end

  def new
    @teacher_subject_relations = TeacherSubjectRelation.new
    @teacher_subject_relations.teacher_id = params[:teachers_id] unless params[:teachers_id].nil?
  end

  def add_all
    unless params[:teachers_id].nil?
      teacher = current_user.teachers.find(params[:teachers_id])
      teacher.subjects << Subject.all
      teacher.save!
      redirect_to teacher_subject_relations_path(:params => {teachers_id:teacher.id}) and return
    end
    redirect_to teacher_subject_relations_path()
  end

  def delete_all
    unless params[:teachers_id].nil?
      teacher = current_user.teachers.find(params[:teachers_id])
      teacher.subjects.clear
      teacher.save!
      redirect_to teacher_subject_relations_path(:params => {teachers_id:teacher.id}) and return
    end
    redirect_to teacher_subject_relations_path()
  end

  def create
    @teacher_subject_relations = TeacherSubjectRelation.new
    @teacher_subject_relations.teacher_id = params[:teacher_subject_relation][:teacher_id] unless params[:teacher_subject_relation][:teacher_id].nil?
    @teacher_subject_relations.subject_id = params[:teacher_subject_relation][:subject] unless params[:teacher_subject_relation][:subject].nil?
    if @teacher_subject_relations.save
      redirect_to teacher_subject_relations_path(:params => {teachers_id:params[:teacher_subject_relation][:teacher_id]})
    else
      flash[:error] = @teacher_subject_relations.errors.full_messages
      redirect_to new_teacher_subject_relation_path(teachers_id:params[:teacher_subject_relation][:teacher_id])
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy

    subj = TeacherSubjectRelation.find(params[:id])
    teacher = subj.teacher
    subj.delete
    redirect_to teacher_subject_relations_path(:params => {teachers_id:teacher.id})
  end
end
