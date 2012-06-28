module SendGridWebApi
  autoload :Modules, 'web_api/modules'
  
  class Client < Base
    include SendGridWebApi::Modules
    
    def base_url
      "https://sendgrid.com/api/"
    end
    
  end
end