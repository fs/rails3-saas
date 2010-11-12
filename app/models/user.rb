class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  attr_accessible :email, :password, :password_confirmation

  belongs_to :account

end
