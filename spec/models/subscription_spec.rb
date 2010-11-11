require 'spec_helper'

describe Subscription do
  it { should belong_to :account }
  it { should belong_to :plan }
  it { should have_one :profile }

  describe 'on create' do
    context 'with valid params' do
      it 'should create new Subscription instance'
      it 'should create new SubscriptionProfile instance associated with this subscription'
    end

    context 'with invalid params' do
      it 'should not create new Subscription instance'
      it 'should not create new SubscriptionProfile instance'
    end
  end

  describe '#renew!' do
    context 'when charge will be success' do
      it 'should update next renew date'
      it 'should activate account'
    end

    context 'when change will be failed' do
      it 'should not update next renew date'
      it 'should set account status in the error state'
    end
  end

  describe '#charge!(money)' do
    context 'when user has payment profile' do
      context 'when user have enought money' do
        it 'should charge $10 using payment gateway'
        it 'should record success transaction'
      end

      context 'when authentification failed in the gateway' do
        it 'should record failed transaction'
        it 'should raise Subscription::AuthorizationFailed.new(response)'
      end

      context 'when user have no enought money' do
        it 'should record failed transaction'
        it 'should raise Subscription::CaptureFailed.new(response)'
      end
    end

    context 'when user has no payment profile' do
      it 'should record failed transaction'
      it 'should raise Subscription::EmptyPaymentProfile'
    end
  end
end
