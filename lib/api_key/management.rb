module SendGridWebApi::ApiKeyModules
  class Management < SendGridWebApi::ApiKey
    APIKEY_URL = "api_keys"

    def get options = {}
      management_get_url = APIKEY_URL
      if options.key?(:apikey_id)
        management_get_url += "/#{options[:apikey_id]}"
        options.delete(:apikey_id)
      end
      query_api(management_get_url, process_header_options(options))
    end

    def create options = {}
      query_post_json_api(APIKEY_URL, process_header_options(options))
    end

    def delete apikey_id, options = {}
      query_delete_api(APIKEY_URL+"/#{apikey_id}", process_header_options(options))
    end

    def update apikey_id, options = {}
      query_patch_api(APIKEY_URL+"/#{apikey_id}", process_header_options(options))
    end

    private
    def process_header_options options
      on_behalf_of = options.delete(:on_behalf_of)
      options.merge!({ headers: { "on-behalf-of" => on_behalf_of } }) unless on_behalf_of.nil?
      options
    end
  end
end