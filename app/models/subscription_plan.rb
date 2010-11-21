class SubscriptionPlan < ActiveRecord::Base
  has_many :subscriptions

  validates :name, :uniqueness => true, :presence => true
  validates :trial_period, :renewal_period, :numericality => true, :presence => true
  validates :amount, :presence => true

  def to_param
    name.to_param
  end

  def free?
    amount == 0
  end

  def paid?
    !free?
  end
  
  def trial?
    trial_period != 0 && paid?
  end
end