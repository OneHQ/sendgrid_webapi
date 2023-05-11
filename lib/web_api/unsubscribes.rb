module SendGridWebApi::Modules
  class Unsubscribe < SendGridWebApi::Client
    def base_url
      "https://api.sendgrid.com/v3/"
    end

    # Retrieve a list of all email address that are globally suppressed.
    # You can use the offset and limit parameters to retrieve a custom number of results.
    # You can use the start_time and end_time parameters to filter by time frames.
    def get options = {}
      unsubscribe_url = "suppression/unsubscribes"
      query_api(unsubscribe_url, process_header_options(options))
    end

    # Add one or more email addresses to the global suppressions group.
    # Expects options => recipient_emails: ["test@example.com"]
    def add options = {}
    unsubscribe_url = "asm/suppressions/global"
      query_post_json_api(unsubscribe_url, process_header_options(options))
    end

    # This method will delete all unsubscribes from the given email
    def delete options = {}
      unsubscribe_url = "asm/suppressions/global"
      delete_url = unsubscribe_url + "/#{options[:email]}"
      options.delete(:email)

      query_delete_api(delete_url, process_header_options(options))
    end
  end
end