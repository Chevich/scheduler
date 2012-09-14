class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :rooms, :dependent => :delete_all
  has_many :klasses, :dependent => :delete_all
  has_many :teachers, :dependent => :delete_all
  has_many :subjects, :dependent => :delete_all
  has_many :timetables, :dependent => :delete_all
  has_many :settings, :dependent => :delete_all
end
