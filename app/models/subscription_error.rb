module SubscriptionError
  class BasicError < RuntimeError
  end

  class ResponseFailed < BasicError
    attr_reader :response
    
    def initialize(response = nil)
      @response = response
    end
  end

  class StoreFailed < ResponseFailed
  end
  
  class AuthorizationFailed < ResponseFailed
  end

  class CaptureFailed < ResponseFailed
  end
end
