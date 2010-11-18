Factory.define :subscription do |f|
  f.association :profile, :factory => :subscription_profile
end
