Factory.define :subscription do |f|
  f.association :account
  f.association :plan, :factory => :free_subscription_plan
  f.association :profile, :factory => :subscription_profile
end
