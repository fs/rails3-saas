require 'spec_helper'

describe SubscriptionPlan do
  it { should have_many :subscriptions }
end
