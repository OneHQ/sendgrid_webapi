module SendGridWebApi
  class Bounce < Client
    def get options = {}
      bounce_get_url = "bounces.get.json"
      query_api(bounce_get_url, options)
    end

    def delete options = {}
      bounce_delete_url = "bounces.delete.json"
      query_api(bounce_delete_url, options)
    end
  end
end