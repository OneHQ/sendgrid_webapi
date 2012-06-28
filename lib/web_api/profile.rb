module SendGridWebApi::Modules
  class Profile < SendGridWebApi::Client
    def get options = {}
      profile_get_url = "profile.get.json"
      query_api(profile_get_url, options)
    end

    def set options = {}
      profile_set_url = "profile.set.json"
      query_api(profile_set_url, options)
    end

    def set_password options = {}
      profile_set_password_url = "password.set.json"
      query_api(profile_set_password_url, options)
    end

    def set_username options = {}
      profile_set_username_url = "profile.setUsername.json"
      query_api(profile_set_username_url, options)
    end

    def set_email options = {}
      profile_set_email_url = "profile.setEmail.json"
      query_api(profile_set_email_url, options)
    end

  end  
end