#coding: utf-8
class KlassSubjectRelationsController < ApplicationController
  def index
    @klass = Klass.find(params[:klasses_id]) unless params[:klasses_id].nil?
    @klass_subject_relations = KlassSubjectRelation.where("klass_id = ?", @klass.id)
  end

  def new
    @klass_subject_relations = KlassSubjectRelation.new
    @klass_subject_relations.klass_id = params[:klasses_id] unless params[:klasses_id].nil?
  end

  def add_all
    unless params[:klasses_id].nil?
      klass = Klass.find(params[:klasses_id])
      current_user.subjects.where('level = ?',klass.level).each do |subject|
        relation = KlassSubjectRelation.new
        relation.klass = klass
        relation.subject = subject
        relation.hours_per_week = subject.hours_per_week
        klass.klass_subject_relations << relation
      end
      klass.save!
      redirect_to klass_subject_relations_path(:params => {klasses_id:klass.id}) and return
    end
    redirect_to klass_subject_relations_path()
  end

  def delete_all
    unless params[:klasses_id].nil?
      klass = current_user.klasses.find(params[:klasses_id])
      klass.subjects.clear
      klass.save!
      redirect_to klass_subject_relations_path(:params => {klasses_id:klass.id}) and return
    end
    redirect_to klass_subject_relations_path()
  end

  def create
    @klass_subject_relations = KlassSubjectRelation.new
    @klass_subject_relations.klass_id = params[:klass_subject_relation][:klass_id] unless params[:klass_subject_relation][:klass_id].nil?
    @klass_subject_relations.subject_id = params[:klass_subject_relation][:subject] unless params[:klass_subject_relation][:subject].nil?
    @klass_subject_relations.hours_per_week = params[:klass_subject_relation][:hours_per_week] unless params[:klass_subject_relation][:hours_per_week].nil?
    if @klass_subject_relations.save
      redirect_to klass_subject_relations_path(:params => {klasses_id:params[:klass_subject_relation][:klass_id]})
    else
      flash[:error] = @klass_subject_relations.errors.full_messages
      redirect_to new_klass_subject_relation_path(klasses_id:params[:klass_subject_relation][:klass_id])
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
    subj = KlassSubjectRelation.find(params[:id])
    klass = subj.klass
    subj.delete
    redirect_to klass_subject_relations_path(:params => {klasses_id:klass.id})
  end
end
