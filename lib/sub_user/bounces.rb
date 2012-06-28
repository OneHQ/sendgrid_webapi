module SendGridWebApi::SubUserModules
  class Bounce < SendGridWebApi::SubUser
    BOUNCE_URL = "api/user.bounces.json"
    
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      query_api(BOUNCE_URL, options)
    end
  
    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(BOUNCE_URL, options)    
    end
  end
end