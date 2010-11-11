require 'spec_helper'

describe Account do
  it { should belong_to :owner }
  it { should have_one :subscription }
  it { should have_many :users }

  describe 'on create' do
    context 'with valid params' do
      context 'when User does not exists' do
        it 'should create new Account instance'
        it 'should create new User instance associated with this account'
        it 'should create new Subscription instance associated with this account'
      end

      context 'when User exists' do
        it 'should create Account instance'
        it 'should not create new User instance'
        it 'should create new Subscription instance associated with this account'
      end
    end

    context 'with invalid params' do
      it 'should not create new Account instance'
      it 'should not create new User instance'
      it 'should not create new Subscription instance associated with this account'
    end
  end
end
