class ActiveMerchant::Billing::TrustCommerceGateway::Response < ActiveMerchant::Billing::Response
  def token
    @params['billingid']
  end
end
