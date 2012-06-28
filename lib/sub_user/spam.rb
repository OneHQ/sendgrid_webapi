module SendGridWebApi::SubUserModules
  class Spam < SendGridWebApi::SubUser
    SPAM_URL = "api/user.spamreports.json"
    
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      query_api(SPAM_URL, options)
    end

    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(SPAM_URL, options)    
    end
  end
end