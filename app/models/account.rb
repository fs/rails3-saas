class Account < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_one :subscription
  has_many :users

  accepts_nested_attributes_for :subscription
  accepts_nested_attributes_for :owner

  validates :subscription, :presence => true
  validates :owner, :presence => true

  before_create :add_user

  protected

  def add_user
    self.users << self.owner
  end
end