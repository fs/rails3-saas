require 'spec_helper'

describe Subscription do
  it { should belong_to :account }
  it { should belong_to :plan }
  it { should have_one :profile }

  context 'validates' do
    it { should validate_presence_of :profile }
  end
  
  context 'existing subscription' do
    it 'should return the amount in pennies'
    it 'should return user limit'
  end

  context 'on initizlize' do
    it "should set values from the assigned plan"
  end

  context 'on create' do
    before do
      stub_store_card_in_gateway_to(true)
      @subscription = Subscription.new
    end

    context 'with valid credit card' do
      before do
        stub_test_card_in_gateway_to(true)

        @subscription.profile_attributes = { :card => Factory(:credit_card) }
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

        @subscription.profile_attributes = { :card => Factory(:invalid_credit_card) }
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
