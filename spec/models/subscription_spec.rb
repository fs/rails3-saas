require 'spec_helper'

describe Subscription do

  before do
    # disable real gateway calls
    stub_store_card_in_gateway_to(true)
    # gateway checks are valid
    stub_test_card_in_gateway_to(true)
  end

  it { should belong_to :account }
  it { should belong_to :plan }
  it { should have_one :profile }

  context 'validates' do
    it { should validate_presence_of :profile }
  end

  context '#plan=(plan)' do
    before { @subscription = Subscription.new }

    context 'should set values from the assigned plan' do
      before do
        @plan              = Factory.build :basic_subscription_plan
        @subscription.plan = @plan
      end

      it { @subscription.plan_name.should eql(@plan.name) }
      it { @subscription.user_limit.should eql(@plan.user_limit) }
      it { @subscription.amount.should eql(@plan.amount) }
      it { @subscription.trial_period.should eql(@plan.trial_period) }
      it { @subscription.renewal_period.should eql(@plan.renewal_period) }
    end

    context 'state' do
      subject { @subscription }
      
      context 'when plan is Basic' do
        before { @subscription.plan = Factory :basic_subscription_plan }
        it { should be_trial }
      end

      context 'when plan is Free' do
        before { @subscription.plan = Factory :free_subscription_plan }
        it { should be_active }
      end

      context 'when plan without trial period' do
        before { @subscription.plan = Factory :basic_without_trial_period_subscription_plan }
        it { should be_active }
      end
    end
  end

  context '#plan' do
    before { @subscription = Factory.build :subscription }
    subject { @subscription.plan }

    it { should be_an_instance_of SubscriptionPlan }
    it { should be_readonly }

    context 'should restore values from subscription' do
      it { @subscription.plan.name.should eql(@subscription.plan_name) }
      it { @subscription.plan.user_limit.should eql(@subscription.user_limit) }
      it { @subscription.plan.amount.should eql(@subscription.amount) }
      it { @subscription.plan.trial_period.should eql(@subscription.trial_period) }
      it { @subscription.plan.renewal_period.should eql(@subscription.renewal_period) }
    end
  end

  context 'on create' do
    before do
      @subscription = Subscription.new
    end

    context 'with valid credit card' do
      before do
        stub_test_card_in_gateway_to(true)

        @subscription.profile_attributes = {:card => Factory(:credit_card)}
        @subscription.save
      end

      subject { @subscription }
      it { should be_persisted }

      context 'profile' do
        subject { @subscription.profile }
        it { should be_persisted }
      end

      context 'on paid plan' do
        context 'with trial period' do
          it "should be created as a trial"
          it "should be created with a specified renewal date"
        end

        context 'without trial period' do
          it "should be created as a active"
          it "should be created with a renewal date for today"
        end
      end

      context 'on free plan' do
        it "should be created as active"
        it "should be created with a specified renewal date"
      end
    end

    context 'with invalid credit card' do
      before do
        stub_test_card_in_gateway_to(false)

        @subscription.profile_attributes = {:card => Factory(:invalid_credit_card)}
        @subscription.save
      end

      subject { @subscription }
      it { should_not be_valid }
      it { should_not be_persisted }

      context 'profile' do
        subject { @subscription.profile }
        it { should_not be_persisted }
      end
    end
  end

  describe '#renew!' do
    context 'on free plan' do
      it 'should not charge'
      it 'should not create transaction'
      it 'should change renewal date'
      it 'should activate account'
    end

    context 'on paid plan' do
      context 'when charge will be success' do
        context 'when renewal date in the past' do
          it 'should update next renew date'
          it 'should charge accordingly with amount in the subscription plan data'
          it 'should activate account'
          it 'should record transaction'
        end

        context 'when there is no renewal date' do
          it 'should update next renew date'
          it 'should charge accordingly with amount in the subscription plan data'
          it 'should activate account'
          it 'should record transaction'
        end

        context 'when renewal date in the future' do
          it 'should not charge'
          it 'should not change renewla date'
          it 'should not record transaction'
        end
      end
    end

    context 'when change will be failed' do
      it 'should not update next renew date'
      it 'should set account status in the error state'
      it 'should record transaction'
    end
  end

  describe 'when switching to a plan' do
    context 'with a user limit' do
      context 'less than the current number of users' do
        it 'should refuse switching'
      end

      context 'greater than the current number of users' do
        it 'should allow switching'
      end
    end
  end
end
