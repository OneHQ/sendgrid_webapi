module SendGridWebApi::Modules
  class Bounce < SendGridWebApi::Client
    def get options = {}
      bounce_get_url = "bounces.get.json"
      query_api(bounce_get_url, options)
    end

    def delete options = {}
      bounce_delete_url = "bounces.delete.json"
      query_api(bounce_delete_url, options)
    end

    def count options = {}
      bounces_count_url = "bounces.count.json"
      query_api(bounces_count_url, options)
    end
  end
end