module SendGridWebApi::Modules
  class InvalidEmail < SendGridWebApi::Client
    INVALID_EMAILS_URL = "suppression/invalid_emails"

    def base_url
      "https://api.sendgrid.com/v3/"
    end

    # Retrieve a list of all invalid email addresses.
    # You can use the offset and limit parameters to retrieve a custom number of results.
    # You can use the start_time and end_time parameters to filter by time frames.
    def get options = {}
      query_api(INVALID_EMAILS_URL, process_header_options(options))
    end

    # This method will delete all invalid_emails from the given email
    def delete options = {}
      delete_url = INVALID_EMAILS_URL+"/#{options[:email]}"
      options.delete(:email)
      query_delete_api(delete_url, process_header_options(options))
    end
  end
end