module SendGridWebApi::Modules
  class Bounce < SendGridWebApi::Client
    BOUNCES_URL = "suppression/bounces"

    def base_url
      "https://api.sendgrid.com/v3/"
    end

    # Retrieve all of your bounces.
    # A maximum of 500 bounces will be returned per query.
    # You can use the offset and limit parameters to retrieve more or less than 500 results.
    # You can use the start_time and end_time parameters to filter by time frames.
    def get options = {}
      query_api(BOUNCES_URL, process_header_options(options))
    end

    # This method will delete all bounces from the given email.
    def delete options = {}
      delete_url = BOUNCES_URL+"/#{options[:email]}"
      options.delete(:email)
      query_delete_api(delete_url, process_header_options(options))
    end

    # Deprecated: Count is no longer supported on SendGrid v3.
    # As an alternative, SendGrid recommends to query depending on time frames since `get` limit is 500.
    def count options = {}
      count = query_api(BOUNCES_URL, process_header_options(options)).count
      {count: count}
    end
  end
end