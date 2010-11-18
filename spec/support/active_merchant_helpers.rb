module ActiveMerchantHelpers
  def stub_gateway_method(method, stubs)
    response = Object.new

    stub(response) do |r|
      stubs.each do |stubbed_method, value|
        r.__send__(stubbed_method) { value }
      end
    end

    stub(configatron.gateway.current).__send__(method) { response }
  end
  
  def stub_test_card_in_gateway_to(success_or_not)
    stub_gateway_method(:authorize, :success? => true, :authorization => Object.new)
    stub_gateway_method(:void, :success? => success_or_not)
  end

  def stub_store_card_in_gateway_to(success_or_not, token = 1)
    stub_gateway_method(:store, :success? => success_or_not, :token => token)
  end
end