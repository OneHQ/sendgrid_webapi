module SendGridWebApi::SubUserModules
  class WhiteLabel < SendGridWebApi::SubUser
    WHITE_LABEL_URL = "apiv2/customer.whitelabel.json"
    
    def get options = {}
      options.merge!({:task => "list"}) unless options[:task]
      query_api(WHITE_LABEL_URL, options)
    end

    def add options = {}
      options.merge!({:task => "append"}) unless options[:task]
      query_api(WHITE_LABEL_URL, options)
    end
    
  end
end