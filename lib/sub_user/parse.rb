module SendGridWebApi::SubUserModules
  class ParseEmail < SendGridWebApi::SubUser
    PARSE_URL = "apiv2/customer.parse.json"
    
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      query_api(PARSE_URL, options)
    end

    def set options = {}
      options.merge!({:task => "set"}) unless options[:task]
      query_api(PARSE_URL, options)
    end

    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(PARSE_URL, options)
    end
  end
end