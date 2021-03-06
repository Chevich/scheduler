class TeacherKlassSubjectRelationsController < ApplicationController
  def index
    @teacher = current_user.teachers.find(params[:teachers_id]) unless params[:teachers_id].nil?
    @teacher_klass_subject_relations = TeacherKlassSubjectRelation.where("teacher_id = ?", @teacher.id)
  end

  def new
    @teacher_klass_subject_relations = TeacherKlassSubjectRelation.new
    @teacher_klass_subject_relations.teacher_id = params[:teachers_id] unless params[:teachers_id].nil?
  end

  def add_all
    unless params[:teachers_id].nil?
      teacher = current_user.teachers.find(params[:teachers_id])
      current_user.klasses.each do |klass|
        klass.subjects.each do |subject|
          if teacher.subjects.include?(subject)
            relation = TeacherKlassSubjectRelation.new
            relation.teacher = teacher
            relation.klass = klass
            relation.subject = subject
            teacher.teacher_klass_subject_relations << relation
          end
        end
      end
      teacher.save!
      redirect_to teacher_klass_subject_relations_path(:params => {teachers_id:teacher.id}) and return
    end
    redirect_to teacher_klass_subject_relations_path()
  end

  def delete_all
    unless params[:teachers_id].nil?
      teacher = current_user.teachers.find(params[:teachers_id])
      teacher.teacher_klass_subject_relations.each do |item|
        item.delete
      end
      teacher.save!
      redirect_to teacher_klass_subject_relations_path(:params => {teachers_id:teacher.id}) and return
    end
    redirect_to teacher_klass_subject_relations_path()
  end

  def create
    @teacher_klass_subject_relations = TeacherKlassSubjectRelation.new
    @teacher_klass_subject_relations.teacher_id = params[:teacher_klass_subject_relation][:teacher_id] unless params[:teacher_klass_subject_relation][:teacher_id].nil?
    @teacher_klass_subject_relations.klass_id = params[:teacher_klass_subject_relation][:klass] unless params[:teacher_klass_subject_relation][:klass].nil?
    @teacher_klass_subject_relations.subject_id = params[:teacher_klass_subject_relation][:subject] unless params[:teacher_klass_subject_relation][:subject].nil?
    if @teacher_klass_subject_relations.save
      redirect_to teacher_klass_subject_relations_path(:params => {teachers_id:params[:teacher_klass_subject_relation][:teacher_id]})
    else
      flash[:error] = @teacher_klass_subject_relations.errors.full_messages
      redirect_to new_teacher_klass_subject_relation_path(teachers_id:params[:teacher_klass_subject_relation][:teacher_id])
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
    subj = TeacherKlassSubjectRelation.find(params[:id])
    teacher = subj.teacher
    subj.delete
    redirect_to teacher_klass_subject_relations_path(:params => {teachers_id:teacher.id})
  end
end
