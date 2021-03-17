module SendGridWebApi
  autoload :ApiKeyModules, 'api_key/modules'

  class ApiKey < Base
    include SendGridWebApi::ApiKeyModules

    def base_url
      "https://api.sendgrid.com/v3/"
    end
  end
end