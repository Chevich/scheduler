class KlassSubjectRelation < ActiveRecord::Base
  belongs_to :klass
  belongs_to :subject

  attr_accessible :klass, :subject, :hours_per_week

  validates :klass, :presence => true
  validates :hours_per_week, :presence => true, :inclusion => { :in => 1..80 }
  validates :subject, :presence => true
  validates_uniqueness_of :subject_id, :scope => [:klass_id]
end
