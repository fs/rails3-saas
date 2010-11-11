# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :subscription_profile do |f|
  f.subscription_id 1
  f.payment_auth_id "MyString"
  f.card_number "MyString"
  f.card_expired_on "2010-11-11"
  f.card_holder_name "MyString"
end
