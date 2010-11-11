class Account < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_one :subscription
  has_many :users
end