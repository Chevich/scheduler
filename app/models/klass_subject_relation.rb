class KlassSubjectRelation < ActiveRecord::Base
  belongs_to :klass
  belongs_to :subject
end
