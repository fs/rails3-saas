class Account < ActiveRecord::Base

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  has_one :subscription
  has_many :users
  
end