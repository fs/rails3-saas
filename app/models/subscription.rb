class Subscription < ActiveRecord::Base
  belongs_to :account
  belongs_to :plan, :class_name => 'SubscriptionPlan', :foreign_key => :subscription_plan_id
  has_one :profile, :class_name => 'SubscriptionProfile'

  validates :profile, :plan_name, :amount, :trial_period, :renewal_period, :user_limit, :presence => true
  accepts_nested_attributes_for :profile

  def plan=(plan)
    clone_attributes_from_plan(plan)
    set_state_from_plan(plan)
    set_next_renewal_date_from_plan(plan)
  end

  def plan
    plan = SubscriptionPlan.new(
        :name => plan_name,
        :amount => amount,
        :trial_period => trial_period,
        :renewal_period => renewal_period,
        :user_limit => user_limit
    )
    plan.readonly!
    plan
  end

  def trial?
    state == 'trial'
  end

  def active?
    state == 'active'
  end

  private

  def clone_attributes_from_plan(plan)
    self.plan_name = plan.name

    %w{amount trial_period renewal_period user_limit}.each do |field|
      send("#{field}=", plan.send(field))
    end
  end

  def set_state_from_plan(plan)
    self.state = plan.trial? ? 'trial' : 'active'
  end

  def set_next_renewal_date_from_plan(plan)
    period = if plan.trial?
               plan.trial_period
             elsif plan.free?
               plan.renewal_period
             elsif plan.paid?
               0
             end

    self.next_renewal_at = Time.now.advance(:days => period)
  end
end