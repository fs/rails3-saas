require 'spec_helper'

describe SubscriptionProfile do
  it { should belong_to :subscription }

  context 'on create' do
    context 'with valid params' do
      it 'should store card in the payment gateway'
      it 'should save card id from the payment gateway'
      it 'should save escaped with stars card number'
      it 'should save card holder name'
      it 'should save card expiratoin date'
      it 'should create new SubscriptionProfile instance'
    end
  end

  describe 'on destroy' do
    it 'should remove card from payment gateway'
    it 'should remove SubscriptionProfile instance'
  end
end
