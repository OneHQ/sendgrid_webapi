module SendGridWebApi::Modules
  class Spam < SendGridWebApi::Client
    SPAM_REPORTS_URL = "suppression/spam_reports"

    def base_url
      "https://api.sendgrid.com/v3/"
    end

    # Retrieve a list of all spam reports.
    # You can use the offset and limit parameters to retrieve a custom number of results.
    # You can use the start_time and end_time parameters to filter by time frames.
    def get options = {}
      query_api(SPAM_REPORTS_URL, process_header_options(options))
    end

    # This method will delete all spam_reports from the given email.
    def delete options = {}
      delete_url = SPAM_REPORTS_URL+"/#{options[:email]}"
      options.delete(:email)
      query_delete_api(delete_url, process_header_options(options))
    end
  end
end