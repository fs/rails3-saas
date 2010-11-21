Factory.define :subscription do |f|
  f.association :profile, :factory => :subscription_profile
  f.plan_name 'Free'
  f.amount 0
  f.trial_period 30
  f.renewal_period 30
  f.user_limit 2
end
