if Gem::Version.new(Faraday::VERSION) < Gem::Version.new('2.0')
  require 'faraday_middleware'
end

module SendGridWebApi
  class Base
    attr_accessor :api_key

    def initialize api_key
      @api_key  = api_key
    end

    def make_request_url url, options
      "#{url}?#{builder_options(options)}"
    end

    def builder_options options
      to_query(options)
    end

    def query_api url, options
      headers = options.delete(:headers)
      (session.get(make_request_url(url, options)) do |req|
        req.headers.merge!(headers) unless headers.nil?
      end).body
    end

    def query_post_api url, options
      headers = options.delete(:headers)
      (session.post(url, builder_options(options)) do |req|
        req.headers.merge!(headers) unless headers.nil?
      end).body
    end

    def query_post_json_api url, options
      headers = options.delete(:headers)
      (session.post(url) do |req|
        req.headers[:content_type] = 'application/json'
        req.headers.merge!(headers) unless headers.nil?
        req.body = options.to_json
      end).body
    end

    def query_patch_api url, options
      headers = options.delete(:headers)
      (session.patch(url) do |req|
        req.headers[:content_type] = 'application/json'
        req.headers.merge!(headers) unless headers.nil?
        req.body = options.to_json
      end).body
    end

    def query_delete_api url, options
      headers = options.delete(:headers)
      (session.delete(make_request_url(url, options)) do |req|
        req.headers.merge!(headers) unless headers.nil?
      end).body
    end

    def to_query(options)
      Faraday::Utils.build_nested_query(options)
    end

    def session
      @connection ||= ::Faraday.new(
        url: base_url,
        headers: {"Authorization" => "Bearer #{@api_key}"}
      ) do |conn|
        # Forces the connection request and response to be JSON even though
        # Sendgrids API headers do not specify the content type is JSON
        conn.request :url_encoded
        conn.response :json #, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    private
    def process_header_options options
      on_behalf_of = options.delete(:on_behalf_of)
      options.merge!({ headers: { "on-behalf-of" => on_behalf_of } }) unless on_behalf_of.nil?
      options
    end
  end
end
