module SendGridWebApi::ApiKeyModules
  class Management < SendGridWebApi::ApiKey
    APIKEY_URL = "api_keys"

    def get options = {}
      management_get_url = APIKEY_URL
      if options.key?(:apikey_id)
        management_get_url += "/#{options[:apikey_id]}"
        options.delete(:apikey_id)
      end
      query_api(management_get_url, options)
    end

    def create options = {}
      query_post_json_api(APIKEY_URL, options)
    end

    def delete apikey_id
      query_delete_api(APIKEY_URL+"/#{apikey_id}", {})
    end

    def update apikey_id, options = {}
      query_patch_api(APIKEY_URL+"/#{apikey_id}", options)
    end
  end
end