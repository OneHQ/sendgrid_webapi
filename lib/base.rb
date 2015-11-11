require 'faraday_middleware'

module SendGridWebApi
  class Base
    attr_accessor :api_user, :api_key

    def initialize api_user, api_key
      @api_user = api_user
      @api_key  = api_key
    end

    def make_request_url url, options
      "#{url}?#{builder_options(options)}"
    end

    def builder_options options
      options.merge!(:api_user => @api_user, :api_key => @api_key)
      to_query(options)
    end

    def query_api url, options
      session.get(make_request_url(url, options)).body
    end

    def query_post_api url, options
      builder_options(options)
      session.post(url, builder_options(options)).body
    end

    def to_query(options)
      Faraday::Utils.build_nested_query(options)
    end

    def session
      @connection ||= ::Faraday.new base_url do |conn|
        # Forces the connection request and response to be JSON even though
        # Sendgrids API headers do not specify the content type is JSON
        conn.request :url_encoded
        conn.response :json #, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
