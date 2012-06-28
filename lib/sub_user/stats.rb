module SendGridWebApi::SubUserModules
  class Stats < SendGridWebApi::SubUser
    def get options = {}
      stats_get_url = "apiv2/customer.stats.json"
      query_api(stats_get_url, options)
    end
  end  
end