Factory.define :subscription_profile do |f|
  f.association :subscription
  f.payment_auth_id 1
  f.card_number 'XXXX-XXXX-XXXX-4338'
  f.card_type 'Visa'
  f.card_expired_on 1.year.from_now
  f.card_holder_name 'John Smith'
end
