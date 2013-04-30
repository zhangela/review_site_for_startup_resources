class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable # :confirmable
  validates_format_of :email, :with => /(.*)@mit.edu/i, :message => "Must be mit.edu email address"
  has_many :reviews

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :remember_me

end
