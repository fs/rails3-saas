Factory.define :free_subscription_plan, :class => :subscription_plan do |f|
  f.name 'Free'
  f.amount 0
  f.trial_period 30
  f.renewal_period 30
end
