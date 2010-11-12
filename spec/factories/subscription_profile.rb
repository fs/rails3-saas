Factory.define :subscription_profile do |f|
  f.association :subscription
  f.payment_auth_id '123'
  f.card_number '5105105105105100'
  f.card_type 'Visa'
  f.card_expired_on '2010-12-01'
  f.card_holder_name 'John Smith'
end
