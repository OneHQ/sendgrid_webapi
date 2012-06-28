module SendGridWebApi::SubUserModules
  class Unsubscribe < SendGridWebApi::SubUser
    UNSUBSCRIBE_URL = "api/user.unsubscribes.json"
    
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      query_api(UNSUBSCRIBE_URL, options)
    end

    def add options = {}
      options.merge!({:task => "add"}) unless options[:task]
      query_api(UNSUBSCRIBE_URL, options)    
    end

  
    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(UNSUBSCRIBE_URL, options)    
    end
  end
end