%w{Free Basic Premium}.each do |plan_name|
  SubscriptionPlan.create(:name => plan_name)
end