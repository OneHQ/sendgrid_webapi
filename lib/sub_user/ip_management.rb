module SendGridWebApi::SubUserModules
  class IpManagement < SendGridWebApi::SubUser
    def get options = {}
      options.merge!({:list => "all"}) unless options[:list]
      ip_management_get_url = "apiv2/customer.ip.json"
      query_api(ip_management_get_url, options)
    end

    def usage_ip options = {}
      options.merge!({:task => "list"}) unless options[:task]
      ip_management_get_url = "apiv2/customer.sendip.json"
      query_api(ip_management_get_url, options)
    end

    def assign_ip options = {}
      options.merge!({:task => "append"}) unless options[:task]
      options.merge!({:set  => "specify"}) unless options[:set]
      ip_management_get_url = "apiv2/customer.sendip.json"
      query_api(ip_management_get_url, options)
    end

  end
end