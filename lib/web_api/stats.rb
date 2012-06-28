module SendGridWebApi::Modules
  class Stats < SendGridWebApi::Client
    def get options = {}
      stats_get_url = "stats.get.json"
      query_api(stats_get_url, options)
    end
  end  
end