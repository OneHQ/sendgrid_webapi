module SendGridWebApi::SubUserModules
  class Limit < SendGridWebApi::SubUser
    LIMIT_URL = "apiv2/customer.limit.json"
    
    def get options = {}
      options.merge!({:task => "retrieve"}) unless options[:task]
      query_api(LIMIT_URL, options)
    end

    def delete options = {}
      options.merge!({:task => "none"}) unless options[:task]
      query_api(LIMIT_URL, options)    
    end

    def reset options = {}
      options.merge!({:task => "recurring"}) unless options[:task]
      query_api(LIMIT_URL, options)    
    end

    def set_credits options = {}
      options.merge!({:task => "total"}) unless options[:task]
      query_api(LIMIT_URL, options)    
    end

    def increment_credits options = {}
      options.merge!({:task => "increment"}) unless options[:task]
      query_api(LIMIT_URL, options)    
    end

    def decrement_credits options = {}
      options.merge!({:task => "decrement"}) unless options[:task]
      query_api(LIMIT_URL, options)    
    end
  end
end