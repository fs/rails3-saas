Factory.define :free_subscription_plan, :class => :subscription_plan do |f|
  f.name 'Free'
  f.amount 0
  f.trial_period 30
  f.renewal_period 30
  f.user_limit 2
end

Factory.define :basic_subscription_plan, :class => :subscription_plan do |f|
  f.name 'Basic'
  f.amount 10
  f.trial_period 30
  f.renewal_period 30
  f.user_limit 10
end

Factory.define :basic_without_trial_period_subscription_plan, :parent => :basic_subscription_plan do |f|
  f.name 'Basic with out trial period'
  f.trial_period 0
end
