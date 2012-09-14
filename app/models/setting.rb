class Setting < ActiveRecord::Base
  belongs_to :user

  default_scope :order => 'settings.id'

  attr_accessible :name, :value

  validates :user, :presence => true
  validates :value, :presence => true

  def self.week_days
    Setting.where(["name = ?", 'week_days']).first.value.split(',').map{|item| item.to_i} rescue (1..7)
  end

end
