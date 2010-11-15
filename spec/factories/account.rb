Factory.define :account do |f|
  f.association :owner, :factory => :confirmed_user
end
