module SendGridWebApi::Modules
  class EventNotification < SendGridWebApi::Client
    def get options = {}
      event_get_url = "eventposturl.get.json"
      query_api(event_get_url, options)
    end

    def set options = {}
      event_set_url = "eventposturl.set.json"
      query_api(event_set_url, options)
    end

    def delete options = {}
      event_delete_url = "eventposturl.delete.json"
      query_api(event_delete_url, options)
    end
  end  
end