module ActiveMerchantHelpers
  def stub_gateway_method_for(profile, method, stubs)
    response = Object.new

    stub(response) do |r|
      stubs.each do |stubbed_method, value|
        r.__send__(stubbed_method) { value }
      end
    end

    stub(profile.send(:gateway)).__send__(method) { response }
  end
end