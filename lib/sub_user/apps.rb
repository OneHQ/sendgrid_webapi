module SendGridWebApi::SubUserModules
  class App < SendGridWebApi::SubUser
    APP_URL = "apiv2/customer.apps.json"
    
    def list options = {}
      options.merge!({:task => "getavailable"}) unless options[:task]
      query_api(APP_URL, options)
    end

    def activate options = {}
      options.merge!({:task => "activate"}) unless options[:task]
      query_api(APP_URL, options)
    end

    def deactivate options = {}
      options.merge!({:task => "deactivate"}) unless options[:task]
      query_api(APP_URL, options)
    end

    def current_settings options = {}
      options.merge!({:task => "getsettings"}) unless options[:task]
      query_api(APP_URL, options)
    end

    def customize options = {}
      options.merge!({:task => "setup"}) unless options[:task]
      query_post_api(APP_URL, options)
    end

  end
end