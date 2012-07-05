require 'json' unless defined?(JSON)

#api exception
class ApiException < StandardError;end
class AuthenticationError < StandardError;end

module Faraday
  class Response::SendGridWebApi < Response::Middleware
        
    def error_message(result)
      if result[/^[a-z ]+$/i]
        error_msg = result
      else
        error_msg = JSON.parse(result)["error"] || JSON.parse(result)["errors"]
      end
      error_msg.to_s
    end

    def parse_body(body)
      JSON.parse(body)
    end

    def check_status(env)
      status = env[:status].to_s
      if  status == "403" || status == "401"
        raise AuthenticationError.new(error_message(env[:body]))
      elsif status =~ /^5/
        raise ApiException.new("The API call was unsuccessful. You should retry later.")
      elsif status =~ /^4/
        raise ApiException.new(error_message(env[:body]))
      end
    end

    def call(env)
      @app.call(env).on_complete do
        check_status(env)
        env[:body] = parse_body(env[:body])
      end
    end
    
  end
end
