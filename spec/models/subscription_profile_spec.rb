require 'spec_helper'

describe SubscriptionProfile do
  context 'card validation' do
    before do
      @profile = SubscriptionProfile.new(:card => Factory(:invalid_credit_card))
      @profile.valid?
    end

    context 'profile' do
      subject { @profile }
      it { should_not be_valid }

      context 'errors' do
        subject { @profile.errors }
        it { should include :card }
      end
    end

    context 'card' do
      subject { @profile.card }
      it { should_not be_valid }

      context 'errors' do
        subject { @profile.card.errors }
        it { should include :number }
      end
    end
  end

  describe 'on initialize with valid card' do
    before do
      @profile = SubscriptionProfile.new(:card => Factory(:credit_card))
    end

    context 'should set card' do
      subject { @profile.card }
      it { should be_present }
      it { should be_a ActiveMerchant::Billing::CreditCard }
    end

    context 'shold set card number' do
      subject { @profile.card_number }
      it { should be_present }
      it { should =~ /(XXXX\-){3}\d{4}/ }
    end

    context 'should set card expire date' do
      subject { @profile.card_expired_on }
      it { should be_present }
      it { should be_a Date }
    end

    it { @profile.card_type.should be_present }
    it { @profile.card_holder_name.should be_present }
  end

  describe 'on save' do
    before do
      @profile = SubscriptionProfile.new
    end

    subject { @profile }

    context 'with valid card' do
      before do
        @profile.card = Factory(:credit_card)
        @saving = lambda { @profile.save }
      end

      context 'when store in the gateway success' do
        before do
          @saving.call
        end

        it { should be_valid }
        it { should be_persisted }

        context 'payment auth' do
          subject { @profile.payment_auth_id }
          it { should be_present }
        end

        context 'authorization in the gateway' do
          subject { @profile.send(:gateway).authorize(100, @profile.payment_auth_id) }
          it { should be_success }
        end
      end

      context 'when store in the gateway failed' do
        before do
          stub_gateway_method_for(@profile, :store, :success? => false)
        end

        subject { @saving }
        it { should raise_error(SubscriptionError::StoreFailed) }
      end
    end

    context 'with invalid card' do
      before do
        @profile.card = Factory(:invalid_credit_card)
        @profile.save
      end

      it { should_not be_persisted }

      context 'payment auth' do
        subject { @profile.payment_auth_id }
        it { should be_blank }
      end
    end
  end

  describe 'on destroy' do
    before do
      @profile = Factory(:subscription_profile)
      @profile.destroy
    end

    subject { @profile }
    it { should_not be_persisted }

    context 'authorization in the gateway' do
      subject { @profile.send(:gateway).authorize(100, @profile.payment_auth_id) }
      it { should_not be_success }
    end
  end

  describe '#charge!(money)' do
    before do
      @profile = Factory(:subscription_profile)
      @charge = lambda { @profile.charge!(500) } # charges $5
    end

    context 'when successfuly authorized in the gateway' do
      context 'when successfuly caprured money' do
        subject { @charge.call }
        it { should be_true }
        it { should be_an_instance_of ActiveMerchant::Billing::BraintreeBlueGateway::Response }
      end

      context 'when money capture failed' do
        before do
          stub_gateway_method_for(@profile, :capture, :success? => false)
        end

        subject { @charge }
        it { should raise_error(SubscriptionError::CaptureFailed) }
      end
    end

    context 'when authorization in the gateway failed' do
      before do
        stub_gateway_method_for(@profile, :authorize, :success? => false)
      end

      subject { @charge }
      it { should raise_error(SubscriptionError::AuthorizationFailed) }
    end
  end
end
