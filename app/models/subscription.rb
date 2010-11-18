class Subscription < ActiveRecord::Base
  belongs_to :account
  belongs_to :plan, :class_name => 'SubscriptionPlan', :foreign_key => :subscription_plan_id
  has_one :profile, :class_name => 'SubscriptionProfile'

  accepts_nested_attributes_for :profile
  
  validates :profile, :presence => true
end