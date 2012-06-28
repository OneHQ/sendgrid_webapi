module SendGridWebApi::SubUserModules
  class InvalidEmail < SendGridWebApi::SubUser
    INVALID_EMAILS_URL = "apiv2/customer.invalidemails.json"
    
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      query_api(INVALID_EMAILS_URL, options)
    end

    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(INVALID_EMAILS_URL, options)    
    end
  end
end