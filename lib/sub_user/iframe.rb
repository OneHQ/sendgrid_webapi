module SendGridWebApi::SubUserModules
  class Iframe < SendGridWebApi::SubUser
    def get options = {}
      iframe_url = "apiv2/customer.geturl.json"
      query_api(iframe_url, options)
    end
  end  
end