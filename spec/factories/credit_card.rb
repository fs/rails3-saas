Factory.define :credit_card, :class => ActiveMerchant::Billing::CreditCard, :default_strategy => :attributes_for do |f|
  f.first_name 'Steve'
  f.last_name  'Smith'
  f.month      Time.now.month
  f.year       Time.now.year
  f.type       'visa'
  f.number     '4111111111111111'
  f.verification_value '123'
end

Factory.define :invalid_credit_card, :parent => :credit_card do |f|
  f.number     'invalid card number'
end
