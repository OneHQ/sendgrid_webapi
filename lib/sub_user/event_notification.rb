module SendGridWebApi::SubUserModules
  class EventNotification < SendGridWebApi::SubUser
    EVENT_URL = "apiv2/customer.eventposturl.json"
    
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      query_api(EVENT_URL, options)
    end

    def set options = {}
      options.merge!({:task => "set"}) unless options[:task]
      query_api(EVENT_URL, options)
    end

    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(EVENT_URL, options)
    end
  end  
end