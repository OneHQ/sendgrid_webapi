module SendGridWebApi::SubUserModules
  class Auth < SendGridWebApi::SubUser
    
    def login options = {}
      auth_url = "apiv2/customer.auth.json"
      query_api(auth_url, options)
    end
        
  end
end