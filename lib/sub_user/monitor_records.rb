module SendGridWebApi::SubUserModules
  class MonitorRecord < SendGridWebApi::SubUser
    MONITOR_RECORD_URL = "apiv2/customer.monitor.json"
    
    def get options = {}
      options.merge!({:task => "list"}) unless options[:task]
      query_api(MONITOR_RECORD_URL, options)
    end
    
    def create options = {}
      options.merge!({:task => "create"}) unless options[:task]
      query_api(MONITOR_RECORD_URL, options)
    end

    def edit options = {}
      options.merge!({:task => "edit"}) unless options[:task]
      query_api(MONITOR_RECORD_URL, options)
    end

    def delete options = {}
      options.merge!({:task => "delete"}) unless options[:task]
      query_api(MONITOR_RECORD_URL, options)
    end

    def add_user options = {}
      options.merge!({:task => "append"}) unless options[:task]
      query_api(MONITOR_RECORD_URL, options)
    end

    def remove_user options = {}
      options.merge!({:task => "detach"}) unless options[:task]
      query_api(MONITOR_RECORD_URL, options)
    end
  end
end