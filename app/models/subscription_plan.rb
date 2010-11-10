class SubscriptionPlan < ActiveRecord::Base
  has_many :subscriptions
end