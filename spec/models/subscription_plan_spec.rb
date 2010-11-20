require 'spec_helper'

describe SubscriptionPlan do
  context 'validations' do
    it { should validate_presence_of :name }
    #it { should validate_uniqueness_of :name }

    it { should validate_presence_of :amount }
    it { should validate_presence_of :trial_period }

    it { should validate_numericality_of :trial_period }
    it { should validate_presence_of :renewal_period }
    it { should validate_numericality_of :renewal_period }
  end

  context 'associations' do
    it { should have_many :subscriptions }
  end

  context 'existing record' do
    before do
      @plan = Factory :free_subscription_plan
    end

    context '#to_param' do
      subject { @plan.to_param }
      it { should eql(@plan.name) }
    end
  end
end
