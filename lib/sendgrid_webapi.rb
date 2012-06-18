require 'faraday'
require 'cgi'

module SendGridWebApi
  autoload :Modules, 'web_api/modules'
  autoload :Faraday, 'middlewares/sendgrid_response'
  
  class Client
    include SendGridWebApi::Modules
    attr_accessor :api_user, :api_key

    def initialize api_user, api_key
      @api_user = api_user
      @api_key  = api_key
    end

    def base_url
      "https://sendgrid.com/api/"
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
      session.post(url, builder_options(options)).body
    end
    
    def to_query(options)
      options.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"}.join("&")
    end
    
    def session
      @connection ||= ::Faraday.new base_url do |conn|
        conn.use Faraday::Response::SendGridWebApi
        conn.adapter Faraday.default_adapter
      end  
    end
    
  end
end