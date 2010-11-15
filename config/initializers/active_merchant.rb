configatron.gateway.configure_from_hash(YAML.load(File.read("#{Rails.root}/config/gateway.yml"))[Rails.env])

ActiveMerchant::Billing::Base.mode = configatron.gateway.mode = :test if configatron.gateway.test?

configatron.gateway.current = ActiveMerchant::Billing::Base.gateway(configatron.gateway.name).new(configatron.gateway.options.to_hash)
