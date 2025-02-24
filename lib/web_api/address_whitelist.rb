module SendGridWebApi::Modules
  class AddressWhitelist < SendGridWebApi::Client
    ADDRESS_WHITELIST_URL = "mail_settings/address_whitelist"

    def base_url
      "https://api.sendgrid.com/v3/"
    end

    # Retrieve a list of all email addresses whitelist.
    def get options = {}
      query_api(ADDRESS_WHITELIST_URL, process_header_options(options))
    end

    # Add an email address to the whitelist.
    def add options = {}
      query_patch_api(ADDRESS_WHITELIST_URL, process_header_options(options))
    end

    # Delete an email address from the whitelist.
    def delete options = {}
      query_patch_api(ADDRESS_WHITELIST_URL, process_header_options(options))
    end
  end
end
