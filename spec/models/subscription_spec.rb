require 'spec_helper'

describe Subscription do
  it { should belong_to :account }
  it { should belong_to :plan }
  it { should have_one :profile }

  context 'on create' do
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
end
