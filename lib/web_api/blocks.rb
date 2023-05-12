module SendGridWebApi::Modules
  class Block < SendGridWebApi::Client
    BLOCKS_URL = "suppression/blocks"

    def base_url
      "https://api.sendgrid.com/v3/"
    end

    # Retrieve all of your blocks.
    # A maximum of 500 blocks will be returned per query.
    # You can use the offset and limit parameters to retrieve more or less than 500 results.
    # You can use the start_time and end_time parameters to filter by time frames.
    def get options = {}
      query_api(BLOCKS_URL, process_header_options(options))
    end

    # This method will delete all blocks from the given email
    def delete options = {}
      delete_url = BLOCKS_URL+"/#{options[:email]}"
      options.delete(:email)
      query_delete_api(delete_url, process_header_options(options))
    end

    # Deprecated: Count is no longer supported on SendGrid v3.
    # As an alternative, SendGrid recommends to query depending on time frames since `get` limit is 500.
    def count options = {}
      count = query_api(BLOCKS_URL, process_header_options(options)).count
      {count: count}
    end
  end  
end
