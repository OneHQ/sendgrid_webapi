module SendGridWebApi
  autoload :SubUserModules, 'sub_user/modules'
  
  class SubUser < Base
    include SendGridWebApi::SubUserModules
    
    def base_url
      "https://sendgrid.com/"
    end
  end
end