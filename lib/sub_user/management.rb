module SendGridWebApi::SubUserModules
  class Management < SendGridWebApi::SubUser
    def get options = {}
      options.merge!({:task => "get"}) unless options[:task]
      management_get_url = "apiv2/customer.profile.json"
      query_api(management_get_url, options)
    end
  
    def add options = {}
      management_add_url = "apiv2/customer.add.json"
      query_api(management_add_url, options)
    end

    def enable options = {}
      management_enable_url = "apiv2/customer.enable.json"
      query_api(management_enable_url, options)
    end

    def disable options = {}
      management_disable_url = "apiv2/customer.disable.json"
      query_api(management_disable_url, options)
    end

    def website_enable options = {}
      management_website_enable_url = "apiv2/customer.website_enable.json"
      query_api(management_website_enable_url, options)
    end

    def website_disable options = {}
      management_website_disable_url = "apiv2/customer.website_disable.json"
      query_api(management_website_disable_url, options)
    end
  
    def update options = {}
      options.merge!(:task => "set") unless options[:task]
      management_update_url = "apiv2/customer.profile.json"
      query_api(management_update_url, options)    
    end

    def update_password options = {}
      management_set_password_url = "apiv2/customer.password.json"
      query_api(management_set_password_url, options)    
    end

    def update_username options = {}
      options.merge!({:task => "setUsername"}) unless options[:task]
      management_update_url = "apiv2/customer.profile.json"
      query_api(management_update_url, options)    
    end

    def update_email options = {}
      options.merge!({:task => "setEmail"}) unless options[:task]
      management_update_url = "apiv2/customer.profile.json"
      query_api(management_update_url, options)    
    end
  end
end