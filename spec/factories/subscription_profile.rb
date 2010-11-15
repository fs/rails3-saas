Factory.define :subscription_profile do |f|
  f.card Factory(:credit_card)
end
