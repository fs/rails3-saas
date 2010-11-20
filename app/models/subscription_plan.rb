class SubscriptionPlan < ActiveRecord::Base
  has_many :subscriptions

  validates :name, :uniqueness => true, :presence => true
  validates :trial_period, :renewal_period, :numericality => true, :presence => true
  validates :amount, :presence => true

  def to_param
    name
  end
end