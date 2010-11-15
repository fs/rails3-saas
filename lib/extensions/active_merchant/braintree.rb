class ActiveMerchant::Billing::BraintreeBlueGateway::Response < ActiveMerchant::Billing::Response
  def token
    @params['customer_vault_id']
  end
end
